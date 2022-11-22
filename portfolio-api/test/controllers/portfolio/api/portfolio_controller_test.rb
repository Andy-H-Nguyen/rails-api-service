require "test_helper"

module Portfolio::Api
  class PortfolioControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include ActionDispatch::Routing::RouteSet::MountedHelpers

    test "portfolio#index" do
      get "/portfolio-api/"

      assert_response :success
      
      assert_equal(true, response.parsed_body["success"])
    end

    test "portfolio#holdings" do
      get holdings_path

      assert_response :success

      assert_equal(true, response.parsed_body["success"])
    end

    test "portfolio#returns" do
      get returns_path

      assert_response :success

      assert_equal(true, response.parsed_body["success"])
    end
  end
end
