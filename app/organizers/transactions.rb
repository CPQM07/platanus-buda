require_relative '../interactors/fetch_markets.rb'
require_relative '../interactors/fetch_transactions.rb'
require_relative '../interactors/print.rb'

module Organizers
    class Transactions
    include Interactor::Organizer
    
    # Execute those interactors to call and process data, finally print data for humans
    organize Interactors::FetchMarkets, Interactors::FetchTransactions, Interactors::Print
  end
end