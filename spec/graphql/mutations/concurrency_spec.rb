require "rails_helper"
require "concurrent"

module Mutations
  module QuoteTests
    RSpec.describe CreateQuote, type: :request do
      describe ".resolve" do
        
        num_requests = 5
        tickers = ["TeSt", "ABC", "ab", "ga", "ge"]
        timestamp = "2024-10-26T22:00:00Z"
        price = 110
#        it "works" do
#post "/graphql", params: {query: make_query(tickers[0], timestamp, price)}
#        resp = response.body
#        json = JSON.parse(resp)
#        puts json
#        end
                
        it "Handles concurrent GraphQL requests" do
          expect do
            futures = []
            tickers.each do |ticker|
              puts ticker.upcase
              future = Concurrent::Future.execute do
                post "/graphql", params: {query: make_query(ticker, timestamp, price)}
              end
              futures << future
            end
#            Concurrent::Promise.zip(*futures).wait # Waiting for the futures to end
            sleep(10) # Waiting some more for the requests to be handled
          end.to change {Quote.count}.by(num_requests)
        end
      end

      def make_query(tic, tim, pri)
        <<~EOF
          mutation {
            createQuote(input:{
              ticker: "#{tic}",
              timestamp: "#{tim}",
              price: #{pri},
            }
            ) {
              quote {ticker, timestamp, price},
              errors,
            }
          }
        EOF
      end
    end
  end
end
