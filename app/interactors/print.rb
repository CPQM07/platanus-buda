module Interactors
  class Print
    include Interactor
    HUMANIZED_MESSAGE = "💸 Fueron %s %s %s por un monto de %s %s\n"
    BUY = 'comprados 🔺'.freeze
    SELL = 'vendidos  🔻'.freeze
    
    def call
      transactions = context.transactions
      transactions.each{|transaction| humanized(transaction)}
      puts "🤓🤓🤓🤓"
    end
    
    # Method to humanize transaction
    # Params: transaction Hash
    # Return: transaction humanized string
    def humanized(transaction)
      base_currency = transaction['base_currency']
      quote_currency = transaction['quote_currency']
      last_transaction = transaction[:last_transaction]
      amount = last_transaction[1]
      price = last_transaction[2]
      direction = last_transaction[3] == 'buy' ? BUY : SELL
      
      puts HUMANIZED_MESSAGE % [
        direction,
        amount,
        base_currency,
        price,
        quote_currency
      ]
    end
  end
end
