require "test_helper"

module Portfolio::Api
  class StockTest < ActiveSupport::TestCase
    test "Stock is created" do
      assert_equal 22, portfolio_api_stocks(:google).id
      assert_equal "GOOGLE", portfolio_api_stocks(:google).name
      assert_equal "ABC", portfolio_api_stocks(:google).ticker
      assert_equal 48.96, portfolio_api_stocks(:google).current_price
      assert_equal Time.at(1).to_datetime, portfolio_api_stocks(:google).created_at
      assert_equal Time.at(1).to_datetime, portfolio_api_stocks(:google).updated_at
    end

    test "Duplicate tickers are not allowed" do
      assert_raises(ActiveRecord::RecordInvalid, "A ticker with that name already exists") do
        Stock.create!(ticker: "ABC")
      end
    end
  end
end
