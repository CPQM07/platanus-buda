require_relative './api_buda.rb'

module Services
  class Markets
    @@client = Services::ApiBuda.new

    def get_markets
      @@client.fetch("markets")
    end
  end
end