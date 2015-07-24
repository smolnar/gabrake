module Gabrake
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        @app.call(env)
      rescue ::Exception => exception
        Gabrake::Notifier.deliver(exception, env: env) unless exception.is_a?(ActionController::RoutingError)

        raise exception
      end
    end
  end
end
