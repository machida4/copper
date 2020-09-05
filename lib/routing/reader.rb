require "pathname"

# ネストされたハッシュを破壊的にマージする
# TODO: あとで隔離
class ::Hash
  def deep_merge!(second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : Array === v1 && Array === v2 ? v1 | v2 : [:undefined, nil, :nil].include?(v2) ? v1 : v2 }
    self.merge!(second.to_h, &merger)
  end
end

module Routing
  class Reader
    ALLOWED_METHODS = [:get, :post, :put, :delete]

    attr_reader :routes

    ALLOWED_METHODS.each do |method|
      define_method method do |path, hash|
        map_method(method, path, hash)
      end
    end

    def initialize
      @routes = {}
      instance_eval(read_routes)
    end

    private

    def read_routes
      routes_path.read
    end

    def routes_path
      Copper.root.join('config', 'routes.rb')
    end

    def map_method(method, path, hash)
      # compiled_path は Regexp, match_syms は urlマッチングする部分のシンボルが入った配列
      compiled_path, match_syms = compile_path(path)
      # TODO: routesが重くなってきたからクラス作ったほうがいいかもしれない
      routes.deep_merge!({compiled_path => {method.upcase => {controller: hash[:to][:controller], action: hash[:to][:action], match_syms: match_syms}}})
    end

    def compile_path(path)
      match_syms = []

      replaced_path = path.gsub(/:\w+/) do |match|
        match_syms << match.gsub(':', '').to_sym
        '([^/?#]+)'
      end

      compiled_path = /^#{replaced_path}$/

      return compiled_path, match_syms
    end
  end
end
