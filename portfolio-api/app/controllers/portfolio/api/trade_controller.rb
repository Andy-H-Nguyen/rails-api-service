module Portfolio::Api
  class TradeController < ApplicationController
    def create
      permitted_params = params.require(:trade).permit(:stock_ticker, :price, :order_type)
      portfolio = Portfolio.first # Multiple portfolios are out of scope 
      stock = Stock.find_by(ticker: permitted_params[:stock_ticker])
      Trade.create!(
        portfolio_id: portfolio.id,
        stock_id: stock.id,
        price: permitted_params[:price],
        order_type: permitted_params[:order_type])
    end

    def update
      permitted_params = params.require(:trade).permit(:stock_ticker, :price, :order_type)
      stock = Stock.find_by(ticker: permitted_params[:stock_ticker])
      portfolio = Portfolio.first # Multiple portfolios are out of scope 
      Trade.update!(
        portfolio_id: portfolio.id,
        stock_id: stock.id,
        price: permitted_params[:price],
        order_type: permitted_params[:order_type])
    end

    def remove
      id = params.permit(:id)[:id]
      trade = Trade.find(id)
      Trade.delete(trade)
    end
  end
end
