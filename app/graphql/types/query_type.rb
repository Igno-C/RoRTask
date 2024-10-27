# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
#    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
#      argument :id, ID, required: true, description: "ID of the object."
#    end
#
#    def node(id:)
#      context.schema.object_from_id(id, context)
#    end
#
#    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
#      argument :ids, [ID], required: true, description: "IDs of the objects."
#    end
#
#    def nodes(ids:)
#      ids.map { |id| context.schema.object_from_id(id, context) }
#    end
#
#    # Add root-level fields here.
#    # They will be entry points for queries on your schema.
    field :all_quotes, [Types::QuoteType], null: false do
      argument :ticker, String, required: true
    end
    def all_quotes(ticker:)
      return Quote.where(ticker: ticker.upcase)
    end

    field :latest_quote, Types::QuoteType, null: false do
      argument :ticker, String, required: true
    end
    def latest_quote(ticker:)
      return Quote.where(ticker: ticker.upcase).order(timestamp: :desc).first
    end
  end
end
