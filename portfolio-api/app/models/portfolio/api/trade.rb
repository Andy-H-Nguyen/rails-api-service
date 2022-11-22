module Portfolio::Api
  class Trade < ApplicationRecord
    enum :order_type, [ :buy, :sell ]

    belongs_to :portfolio
    belongs_to :stock
  end
end
