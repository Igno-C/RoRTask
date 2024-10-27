# frozen_string_literal: true

class Mutations::CreateQuote < Mutations::BaseMutation
  argument :ticker, String, required: true
  argument :timestamp, GraphQL::Types::ISO8601DateTime, required: true
  argument :price, Int, required: true

  field :quote, Types::QuoteType, null: true
  field :errors, [String], null: false

  def resolve(ticker:, timestamp:, price:)
    # Checking if the input data is valid
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
    
    # Checking if need to update an existing quote
    existing_quote = Quote.find_by(ticker: ticker.upcase, timestamp: timestamp)

    if existing_quote
      if existing_quote.update(price: price)
        return {
          quote: existing_quote,
          errors: []
        }
      else
        return {
          quote: nil,
          errors: existing_quote.errors.full_messages
        }
      end
    end
    # There is no existing quote to update => create new one

    new_quote = Quote.new(ticker: ticker.upcase, timestamp: timestamp, price: price)
    if new_quote.save
      {
        quote: new_quote,
        errors: []
      }
    else
      {
        quote: nil,
        errors: new_quote.errors.full_messages
      }
    end
  end
end
