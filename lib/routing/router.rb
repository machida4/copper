module Routing
  class Router
    attr_reader :routes

    def initialize(routes)
      @routes = routes
    end

    def self.draw(&block)
      eval_block(block)
    end

    def process(req)
      path = req.path_info.to_sym
      method = req.request_method.to_sym

      raw_routes_text = Pathname(__dir__).parent.parent.join('config', 'routes.rb').read
      routes = Routing::Reader.new(raw_routes_text)

      begin
        route = routes[path][method]
        if routes[path][method]
          kontroller(route).call(route[:action])
        else
          Controller.new.not_found
        end
      rescue Exception => err
        puts err.message
        puts err.backtrace

        Controller.new.internal_error
    end

    private
    
    def kontroller(route)
      kontroller_name = route[:controller]
      klass = Object.const_get "#{kontroller_name.capitalize}Controller"
    end

    # debug用
    def routes
      {top: {get: {controller: "top", action: "index"}}}
    end
  end
end