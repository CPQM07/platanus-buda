require_relative '../services/transactions.rb'

# Interactor to fetch last high transaction for each market
# available in buda and share into app trought context
module Interactors
  class FetchTransactions
    include Interactor
  
    def call
      transactions = []
      # For each market, fetch his transactions
      # and get the higher and merge into it
      context.markets.each do |market|
        _market = market.merge!(
          last_transaction: last_transaction(market['name'])
        )
        transactions << _market
      end
      # Set transactions as a context
      context.transactions = transactions
    end

    # Fetch current transactions for a specific market 
    # and get it with the higher price
    # Params: Market name String
    # Return: Entry Transaction Array
    def last_transaction(market)
      response = Services::Transactions.fetch(market)
      entries = response['trades']['entries']
      # index 2 is price regarding to country currency and used it to sort
      entries.sort_by{|entry| entry[2]}.last 
    end
  end
end
