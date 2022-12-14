require "test_helper"

module Portfolio::Api
  class TradeTest < ActiveSupport::TestCase
    test "Trade is created" do
      assert_equal 33, portfolio_api_trades(:google).id
      assert_equal "buy", portfolio_api_trades(:google).order_type
      assert_equal 11, portfolio_api_trades(:google).portfolio_id
      assert_equal 22, portfolio_api_trades(:google).stock_id

      assert_equal Time.at(1).to_datetime, portfolio_api_trades(:google).created_at
      assert_equal Time.at(1).to_datetime, portfolio_api_trades(:google).updated_at
    end
  end
end
