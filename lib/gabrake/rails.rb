module Gabrake
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Gabrake
    end
  end
end
