require "test_helper"

module Portfolio::Api
  class PortfolioTest < ActiveSupport::TestCase
    test "Portfolio is created" do
      assert_equal 11, portfolio_api_portfolios(:google).id
      assert_equal Time.at(1).to_datetime, portfolio_api_portfolios(:google).created_at
      assert_equal Time.at(1).to_datetime, portfolio_api_portfolios(:google).updated_at
    end
  end
end
