module Portfolio::Api
  class Portfolio < ApplicationRecord
    has_many :trades, dependent: :destroy
    has_many :stocks, through: :trades, dependent: :destroy

    def get_returns
      returns = trades.group_by { |trade| trade.stock.name }
      returns.each do |stock_name, trades| 
        returns[stock_name] = {culmulative_return: trades.first.stock.current_price / holding_value(trades)[:average_of_all_buys] }
      end

      returns
    end

    def get_holdings
      holdings = trades.group_by { |trade| trade.stock.name }
      holdings.each do |stock_name, trades| 
        holdings[stock_name] = holding_value(trades)
      end

      holdings
    end

    private
    def holding_value(trades)
      total_shares = 0
      total_purchase_price = 0
      trades.each do |trade|
        total_purchase_price += trade.price * trade.quantity if trade.order_type == 'buy'
        total_shares += trade.quantity if trade.order_type == 'buy'
      end

      average_of_all_buys = total_purchase_price/total_shares

      { total_shares: total_shares, average_of_all_buys: average_of_all_buys}
    end
  end
end
