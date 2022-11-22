module Portfolio::Api
  class PortfolioController < ApplicationController
    def holdings
      holdings = trades.group_by { |trade| trade.stock.name }
      holdings.each do |stock_name, trades| 
        data << stock_name
        data << "\n"
        data << average_of_all_buys(trades)
      end

      render json: { success: true, data: data.string }
    end

    def returns
      render json: { success: true, data: nil }
    end

    def index
      render json: { success: true, data: trades.group_by { |trade| trade.stock.name } }
    end

    private
    def trades
      @trades ||= portfolio.trades
    end

    def portfolio
      @portfolio ||= Portfolio.first
    end

    def average_of_all_buys(trades)
      total_shares = 0
      total_purchase_price = 0
      trades.each do |trade|
        total_purchase_price += trade.price * trade.quantity if trade.order_type == 'buy'
        total_shares += trade.quantity if trade.order_type == 'buy'
      end

      average_of_all_buys = total_purchase_price/total_shares
      return "\t #{total_shares} @ #{average_of_all_buys}\n"
    end
  end
end
