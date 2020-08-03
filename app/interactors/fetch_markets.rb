require_relative '../services/markets.rb'
require 'interactor'

# interactor to fetch all markets available in buda and share into app trought context
module Interactors
  class FetchMarkets
    include Interactor

    def call
      puts "🤓 Holi, procesando transaciones recientes..."
      
      # api call to fetch markets
      if response = Services::Markets.fetch
        # if is successfully, set market as a context
        context.markets = response['markets']
      else
        context.fail!(message: ":c something went wrong")
      end
    end
  end
end
