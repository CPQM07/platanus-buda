require_relative './http_status_codes.rb'
require 'pry'

module Services
  class ApiBuda
    include HttpStatusCodes
    API_ENDPOINT = 'https://www.buda.com/api/v2/'.freeze

    # Main method to make get HTTP calls
    def fetch(endpoint)
      begin
        request(
          http_method: :get,
          endpoint: endpoint
        )
      rescue Faraday::ConnectionFailed => e
        puts "Connection failed 😢😭, please check your internet connection and try again"
      end
    end

    private

    # Method to build a Faraday HTTP Client
    def client
      @_client ||= Faraday.new(API_ENDPOINT) do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
      end
    end

    # Main Method to build and execute HTTP Request like :get, :post, :put, :patch
    # Params:
    # http_method Symbol
    # endpoint String
    # params Hash
    # Return parsed response Json
    def request(http_method:, endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params)
      parsed_response = Oj.load(response.body)
      return parsed_response if response.status == HTTP_OK_CODE
      { code: response.status, response: response.body }
    end
  end
end