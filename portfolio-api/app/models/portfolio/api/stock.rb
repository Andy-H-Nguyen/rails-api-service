module Portfolio::Api
  class Stock < ApplicationRecord
    belongs_to :trade, dependent: :destroy
  end
end
