module Portfolio::Api
  class Trade < ApplicationRecord
    enum :order_type, [ :buy, :sell ]
    belongs_to :portfolio
    has_one :stock, dependent: :destroy
  end
end
