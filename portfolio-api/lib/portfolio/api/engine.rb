module Portfolio
  module Api
    class Engine < ::Rails::Engine
      isolate_namespace Portfolio::Api
    end
  end
end
