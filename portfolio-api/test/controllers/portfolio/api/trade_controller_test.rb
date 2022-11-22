require "test_helper"

module Portfolio::Api
  class TradeControllerTest < ActionDispatch::IntegrationTest
    include ::Portfolio::Api::Engine.routes.url_helpers
    fixtures 'portfolio/api/stocks', 'portfolio/api/trades'

    test "trade#create" do
      assert_difference -> { Trade.count } => 1 do
        post addTrade_path, params: { trade: { stock_ticker: "ABC", price: 7.77, order_type: 'buy'} }, as: :json
      end

      assert_response :success
      # assert_equal({ id: Article.last.id, title: "Ahoy!" }, response.parsed_body)
    end

    test "trade#update" do
      assert_no_changes -> { Trade.count } do
        post "/portfolio-api/updateTrade/33", params: { trade: { stock_ticker: "ABC", price: 7.89, order_type: 'sell'} }, as: :json
      end

      assert_equal(Trade.find(33).portfolio_id, 11) 
      assert_equal(Trade.find(33).price, 7.89) 
      assert_equal(Trade.find(33).order_type, 'sell') 

      assert_response :success
    end

    test "trade#remove" do
      assert_difference -> { Trade.count } => -1 do
        post "/portfolio-api/removeTrade/33"
      end

      assert_response :success
    end
  end
end
