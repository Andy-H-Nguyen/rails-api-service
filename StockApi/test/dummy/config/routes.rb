Rails.application.routes.draw do
  mount StockApi::Engine => "/stock_api"
end
