module Portfolio::Api
  class PortfolioController < ApplicationController
    protect_from_forgery with: :null_session

    def holdings
      begin
        holdings = get_holdings()

        render json: { success: true, data: holdings }
      rescue => e
        render json: { success: false, data: { message: e } }
      end
    end

    def returns
      begin
        returns = get_returns()
        render json: { success: true, data: returns }
      rescue => e
        render json: { success: false, data: { message: e } }
      end
    end

    def index
      begin
        render json: { 
          success: true, 
          data: trades.group_by { |trade| trade.stock.name }}
      rescue => e
        render json: { success: false, data: { message: e } }
      end
  
    end

    private
    def trades
      @trades ||= portfolio.trades
    end

    def portfolio
      # We are only using one portfolio in this iteration
      @portfolio ||= Portfolio.first || Portfolio.create!()
    end
    
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
