require_relative "lib/stock_api/version"

Gem::Specification.new do |spec|
  spec.name        = "stock_api"
  spec.version     = StockApi::VERSION
  spec.authors     = ["Andy Nguyen"]
  spec.email       = ["andy.h.nguyen1996@gmail.com"]
  spec.summary     = "StockApi module for Api Service."
  spec.description = "A portfolio tracking API which allows adding/deleting/updating trades and can do basic return calculations."
  
  spec.add_dependency "rails", ">= 7.0.4"
end
