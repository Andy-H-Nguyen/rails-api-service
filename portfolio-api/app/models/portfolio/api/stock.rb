module Portfolio::Api
  class Stock < ApplicationRecord
    validates :ticker, uniqueness: { 
      message: "A ticker with that name already exists" 
    }

    has_many :trades, dependent: :destroy
  end
end
