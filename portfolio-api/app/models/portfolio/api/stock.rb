module Portfolio::Api
  class Stock < ApplicationRecord
    validates :ticker, uniqueness: { 
      message: "A ticker with that name already exists" 
    }

    validates :name, uniqueness: { 
      message: "A stock with that name already exists" 
    }

    validates :ticker, presence: true
    validates :name, presence: true
    validates :current_price, presence: true

    has_many :trades, dependent: :destroy
  end
end
