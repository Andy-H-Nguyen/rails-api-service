require "test_helper"

module Portfolio::Api
  class TradeControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "the truth" do
      assert true
    end
  end
end
