require "test_helper"

module Portfolio::Api
  class PortfolioControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include ActionDispatch::Routing::RouteSet::MountedHelpers

    test "portfolio#index" do
      get "/portfolio-api/", params: { trade: { title: "Ahoy!" } }, as: :json
    end

    test "portfolio#holdings" do
      get holdings_path, params: { trade: { title: "Ahoy!" } }, as: :json
    end

    test "portfolio#returns" do
      get returns_path, params: { trade: { title: "Ahoy!" } }, as: :json
    end
  end
end
