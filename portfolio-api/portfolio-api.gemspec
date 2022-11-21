require_relative "lib/portfolio/api/version"

Gem::Specification.new do |spec|
  spec.name        = "portfolio-api"
  spec.version     = Portfolio::Api::VERSION
  spec.authors     = ["Andy Nguyen"]
  spec.email       = ["andy.h.nguyen1996@gmail.com"]
  spec.summary     = "A portfolio tracking API which allows adding/deleting/updating trades and can do basic return calculations etc."
  
  spec.add_dependency "rails", ">= 7.0.4"
end
