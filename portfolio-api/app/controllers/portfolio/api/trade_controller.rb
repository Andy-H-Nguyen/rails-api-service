module Portfolio::Api
  class TradeController < ApplicationController
    def create
      permitted_params = params.require(:trade).permit(:stock_ticker, :price, :order_type)
      portfolio = Portfolio.first # Multiple portfolios are out of scope 
      stock = Stock.find_by(ticker: permitted_params[:stock_ticker])
      trade = Trade.create!(
        portfolio_id: portfolio.id,
        stock_id: stock.id,
        price: permitted_params[:price],
        order_type: permitted_params[:order_type])

      render json: { success: true, data: trade }

    end

    def update
      permitted_params = params.require(:trade).permit(:stock_ticker, :price, :order_type)
      stock = Stock.find_by(ticker: permitted_params[:stock_ticker])
      portfolio = Portfolio.first # Multiple portfolios are out of scope 
      id = params.permit(:id)[:id]

      trade = Trade.find(id)
      
      trade.update!(
        portfolio_id: portfolio.id,
        stock_id: stock.id,
        price: permitted_params[:price],
        order_type: permitted_params[:order_type])
      
      render json: { success: true, data: trade }
    end

    def remove
      id = params.permit(:id)[:id]
      trade = Trade.find(id)
      Trade.delete(trade)

      render json: { success: true, data: trade }
    end
  end
end
