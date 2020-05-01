# frozen_string_literal: true

module Routing
  class Router
    def initialize(req)
      @req = req
    end

    def routes
      @routes ||= Reader.new.routes
    end

    def process
      handle_error do
        if (target_route = routes.dig(path, method))
          ctr = kontroller(target_route[:controller], target_route[:action])
          ctr.call(target_route[:action])
        else
          Controller.new.not_found
        end
      end
    end

    private

    def handle_error(&_block)
      yield
    rescue StandardError => e
      puts e.message
      puts e.backtrace

      Controller.new.internal_error
    end

    def path
      @req.path
    end

    def method
      @req.request_method.to_sym
    end

    def kontroller(kontroller_name, action_name)
      klass = Object.const_get "#{kontroller_name.capitalize}Controller"
      klass.new(name: kontroller_name, action: action_name)
    end
  end
end
