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

      assert_equal(true, response.parsed_body["success"])
      assert_equal(portfolio_api_stocks(:google).id, response.parsed_body["data"]["stock_id"])
      assert_equal('7.77', response.parsed_body["data"]["price"])    
      assert_equal('buy', response.parsed_body["data"]["order_type"])
    end

    test "trade#update" do
      assert_no_changes -> { Trade.count } do
        post "/portfolio-api/updateTrade/#{portfolio_api_trades(:google).id}", params: { trade: { stock_ticker: "RELI", price: 7.89, order_type: 'sell'} }, as: :json
      end

      assert_equal(true, response.parsed_body["success"])
      assert_equal(portfolio_api_stocks(:reliance).id, response.parsed_body["data"]["stock_id"].to_i)
      assert_equal('7.89', response.parsed_body["data"]["price"])    
      assert_equal("sell", response.parsed_body["data"]["order_type"])    

      assert_response :success
    end

    test "trade#remove" do
      assert_difference -> { Trade.count } => -1 do
        post "/portfolio-api/removeTrade/#{portfolio_api_trades(:google).id}"
      end

      assert_nil(Trade.find_by(id: portfolio_api_trades(:google).id))

      assert_equal(true, response.parsed_body["success"])
      assert_equal(portfolio_api_stocks(:google).id, response.parsed_body["data"]["stock_id"])
      assert_equal('12.24', response.parsed_body["data"]["price"])    
      assert_equal('buy', response.parsed_body["data"]["order_type"])

      assert_response :success
    end
  end
end
