module Routing
  class Router
    attr_reader :req

    def initialize(req)
      @req = req
    end

    def routes
      @routes ||= Reader.new.routes
    end

    # callって名前紛らわしくない？
    def process
      handle_error do
        target_route = routes.dig(path, method)

        return NotFoundController.new.call(:not_found) if target_route.nil?

        ctr = kontroller(req, target_route[:controller], target_route[:action])
        ctr.call(target_route[:action])
      end
    end

    private

    def handle_error(&block)
      begin
        yield
      rescue Exception => err
        puts err.message
        puts err.backtrace

        InternalErrorController.new.call(:internal_error)
      end
    end

    def path
      @req.path
    end

    def method
      @req.request_method.to_sym
    end

    def kontroller(req, kontroller_name, action_name)
      klass = Object.const_get "#{kontroller_name.capitalize}Controller"
      klass.new(req: req, name: kontroller_name, action: action_name)
    end
  end
end