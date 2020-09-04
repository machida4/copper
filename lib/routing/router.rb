module Routing
  class Router
    attr_reader :req

    def initialize(req)
      @req = req
    end

    def routes
      @routes ||= Reader.new.routes
    end

    def processed_controller
      con = raw_controller

      con.call(con.action)
    end

    private

    def path
      @req.path
    end

    def method
      @req.request_method.to_sym
    end

    def target_route_map
      routes.dig(path, method) || nil
    end

    def raw_controller
      if target_route_map.nil?
        NotFoundController.new(
          req: req,
          name: "not_found",
          action: "not_found",
        )
      else
        get_controller_name(target_route_map[:controller]).new(
          req: req,
          name: target_route_map[:controller],
          action: target_route_map[:action],
        )
      end
    rescue Exception => err
      log_errors(err)

      InternalErrorController.new(
        req: req,
        name: "internal_error",
        action: "internal_error",
      )
    end

    def get_controller_name(kontroller_name)
      Object.const_get "#{kontroller_name.capitalize}Controller"
    end

    def log_errors(err)
      puts err.message
      puts err.backtrace
    end
  end
end
