module Portfolio
  module Api
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
