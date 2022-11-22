require "test_helper"

module Portfolio::Api
  class PortfolioControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include ActionDispatch::Routing::RouteSet::MountedHelpers

    test "portfolio#index" do
      get "/portfolio-api/"

      assert_response :success
      
      assert_equal(true, response.parsed_body["success"])
      assert_equal(
      {"GOOGLE"=>
      [{"id"=>33,
        "portfolio_id"=>11,
        "stock_id"=>22,
        "price"=>"12.24",
        "order_type"=>"buy",
        "quantity"=>1,
        "created_at"=>"1970-01-01T00:00:01.000Z",
        "updated_at"=>"1970-01-01T00:00:01.000Z"}],
     "RELIANCE"=>
      [{"id"=>111,
        "portfolio_id"=>11,
        "stock_id"=>333,
        "price"=>"900.0",
        "order_type"=>"buy",
        "quantity"=>100,
        "created_at"=>"2015-10-04T00:00:00.000Z",
        "updated_at"=>"2015-10-04T00:00:00.000Z"},
       {"id"=>222,
        "portfolio_id"=>11,
        "stock_id"=>333,
        "price"=>"1000.0",
        "order_type"=>"sell",
        "quantity"=>50,
        "created_at"=>"2015-10-05T00:00:00.000Z",
        "updated_at"=>"2015-10-05T00:00:00.000Z"},
       {"id"=>333,
        "portfolio_id"=>11,
        "stock_id"=>333,
        "price"=>"850.0",
        "order_type"=>"buy",
        "quantity"=>100,
        "created_at"=>"2015-10-06T00:00:00.000Z",
        "updated_at"=>"2015-10-06T00:00:00.000Z"}],
     "HDFCBANK"=>
      [{"id"=>4444,
        "portfolio_id"=>11,
        "stock_id"=>444,
        "price"=>"1000.0",
        "order_type"=>"buy",
        "quantity"=>200,
        "created_at"=>"2015-11-05T00:00:00.000Z",
        "updated_at"=>"2015-11-05T00:00:00.000Z"},
       {"id"=>5555,
        "portfolio_id"=>11,
        "stock_id"=>444,
        "price"=>"800.0",
        "order_type"=>"sell",
        "quantity"=>100,
        "created_at"=>"2015-12-07T00:00:00.000Z",
        "updated_at"=>"2015-12-07T00:00:00.000Z"}]}, 
        response.parsed_body["data"])
    end

    test "portfolio#holdings" do
      get holdings_path

      assert_response :success

      assert_equal(true, response.parsed_body["success"])
      assert_equal({
        "GOOGLE"=>
        {"total_shares"=>1, 
          "average_of_all_buys"=>"12.24"}, 
        "RELIANCE"=>
        {"total_shares"=>200, 
         "average_of_all_buys"=>"875.0"}, 
        "HDFCBANK"=>
        {"total_shares"=>200, 
         "average_of_all_buys"=>"1000.0"}}, 
        response.parsed_body["data"])
    end

    test "portfolio#returns" do
      get returns_path

      assert_response :success
      
      assert_equal(true, response.parsed_body["success"])
      
      assert_equal({
        "GOOGLE"=>{"culmulative_return"=>"4.0"}, 
        "RELIANCE"=>{"culmulative_return"=>"0.5"}, 
        "HDFCBANK"=>{"culmulative_return"=>"2.0"}
      }, 
      response.parsed_body["data"])


    end
  end
end
