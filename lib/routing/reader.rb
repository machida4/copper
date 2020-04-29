require "pathname"

module Routing
  class Reader
    attr_reader :routes

    ALLOWED_METHODS = [:get, :post, :put, :delete]

    ALLOWED_METHODS.each do |method|
      define_method method do |path, hash|
        map_method(method, path, hash)
      end
    end

    def initialize(routes_text)
      @routes = {}
      instance_eval(routes_text)
    end

    private

    def map_method(method, path, hash)
      routes.merge!({path => {method.upcase => {controller: hash[:to][:controller], action: hash[:to][:action]}}})
    end
  end
end