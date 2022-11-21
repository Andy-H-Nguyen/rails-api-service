module Portfolio::Api
  class Portfolio < ApplicationRecord
    has_many :trades, dependent: :destroy
    has_many :stocks, through: :trades, dependent: :destroy
  end
end
