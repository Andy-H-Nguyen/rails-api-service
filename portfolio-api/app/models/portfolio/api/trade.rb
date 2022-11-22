module Portfolio::Api
  class Trade < ApplicationRecord
    enum :order_type, [ :buy, :sell ]
    validates :price, presence: true
    validates :quantity, presence: true
    validates :order_type, presence: true

    belongs_to :portfolio
    belongs_to :stock
  end
end
