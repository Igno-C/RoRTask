# frozen_string_literal: true

class Mutations::CreateQuote < Mutations::BaseMutation
  #null true
  argument :ticker, String, required: true
  argument :timestamp, GraphQL::Types::ISO8601DateTime, required: true
  argument :price, Int, required: true

  field :quote, Types::QuoteType, null: true
  field :errors, [String], null: false

  def resolve(ticker:, timestamp:, price:)
#    newq = Quote.create(ticker: ticker, timestamp: timestamp, price: price)
#    {
#      comment: newq,
#      errors: [],    
#    }
    newq = Quote.new(ticker: ticker, timestamp: timestamp, price: price)
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
