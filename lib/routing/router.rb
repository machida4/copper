module Routing
  class Router
    attr_accessor :match_params
    attr_reader :req

    def initialize(req)
      @req = req
      @match_params = Hash.new
    end

    def routes
      @routes ||= Reader.new.routes
    end

    def processed_controller
      con = raw_controller

      con.call()
    end

    private

    def path
      @req.path
    end

    def method
      @req.request_method.to_sym
    end

    # TODO: 名称とクラス等がぐちゃぐちゃなので整理する
    def target_route_map
      # マッチするルートのハッシュを返す
      # TODO: [1]がダサすぎる、なんかないか
      route = routes.find do |k, value|
        k =~ path
      end

      # match_paramsにマッチしたパラメータを詰める
      # (たとえば /users/:id の :id)
      # TODO: 場所は再考
      if route && $~.captures
        $~.captures.each_with_index do |v, index|
          match_params[route[1][method][:match_syms][index]] = v
        end
      end

      # TODO: ここダサすぎて泣ける
      if route
        route[1][method]
      else
        nil
      end
    end

    def raw_controller
      if target_route_map.nil?
        NotFoundController.new(
          req: req,
          name: "not_found",
          action: "not_found",
          match_params: match_params,
        )
      else
        get_controller_name(target_route_map[:controller]).new(
          req: req,
          name: target_route_map[:controller],
          action: target_route_map[:action],
          match_params: match_params,
        )
      end
    rescue Exception => err
      log_errors(err)

      InternalErrorController.new(
        req: req,
        name: "internal_error",
        action: "internal_error",
        match_params: match_params,
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
