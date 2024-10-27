# frozen_string_literal: true

class Mutations::CreateQuote < Mutations::BaseMutation
  argument :ticker, String, required: true
  argument :timestamp, GraphQL::Types::ISO8601DateTime, required: true
  argument :price, Int, required: true

  field :quote, Types::QuoteType, null: true
  field :errors, [String], null: false

  def resolve(ticker:, timestamp:, price:)
    if ticker.length == 0 or ticker.length > 4
      return {
        quote: nil,
        errors: ["Ticker must have between 1 and 4 symbols."],
      }
    end

    unless ticker.match? /\A[a-zA-Z]*\z/
      return {
        quote: nil,
        errors: ["Ticker may only contain letters."],
      }
    end

    if price < 0
      return {
        quote: nil,
        errors: ["Price cannot be negative."],
      }
    end

    newq = Quote.new(ticker: ticker.upcase, timestamp: timestamp, price: price)
    if newq.save
      {
        quote: newq,
        errors: []
      }
    else
      {
        quote: nil,
        errors: order.errors.full_messages
      }
    end
  end
end
