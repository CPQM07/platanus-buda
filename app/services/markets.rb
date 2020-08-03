require_relative './api_buda.rb'

module Services
  class Markets
    @@client = Services::ApiBuda.new

    # Method to call markets from buda using Faraday Client method
    def self.fetch
      @@client.fetch("markets")
    end
  end
end