require_relative './http_status_codes.rb'
require 'faraday'
require 'oj'

module Services
  class ApiBuda
    include HttpStatusCodes
    API_ENDPOINT = 'https://www.buda.com/api/v2/'.freeze

    def fetch(endpoint)
      request(
        http_method: :get,
        endpoint: endpoint
      )
    end

    private

    def client
      @_client ||= Faraday.new(API_ENDPOINT) do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
      end
    end

    def request(http_method:, endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params)
      parsed_response = Oj.load(response.body)
      return parsed_response if response.status == HTTP_OK_CODE
      { code: response.status, response: response.body }
    end
  end
end