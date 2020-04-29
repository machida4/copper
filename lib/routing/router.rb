module Routing
  class Router
    def routes_path
      Copper.root.join('config', 'routes.rb')
    end

    def routes
      @routes ||= Reader.new(routes_path.read).routes
    end

    def process(req)
      path = req.path_info
      method = req.request_method.to_sym

      begin
        if routes.has_key?(path) && routes[path].has_key?(method)
          route = routes[path][method]
          kontroller(route).new.call(route[:action])
        else
          Controller.new.not_found
        end
      rescue Exception => err
        puts err.message
        puts err.backtrace

        Controller.new.internal_error
      end
    end

    def kontroller(route)
      kontroller_name = route[:controller]
      klass = Object.const_get "#{kontroller_name.capitalize}Controller"
    end
  end
end