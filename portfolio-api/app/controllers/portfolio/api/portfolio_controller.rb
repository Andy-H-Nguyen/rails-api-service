module Portfolio::Api
  class PortfolioController < ApplicationController
    protect_from_forgery with: :null_session

    def holdings
      begin
        holdings = portfolio.get_holdings()
        
        render json: { success: true, data: holdings }
      rescue => e
        render json: { success: false, data: { message: e } }
      end
    end

    def returns
      begin
        returns = portfolio.get_returns()
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
      @portfolio ||= Portfolio.first || Portfolio.create!()
    end
  end
end
