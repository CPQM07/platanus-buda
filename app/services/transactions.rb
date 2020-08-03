require_relative './api_buda.rb'

module Services
  class Transactions
    @@client = Services::ApiBuda.new

    # Method to call markets from buda using Faraday Client method
    def self.fetch(market)
      @@client.fetch("markets/#{market}/trades")
    end
  end
end