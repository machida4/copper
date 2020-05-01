# frozen_string_literal: true

require 'pathname'

module Routing
  class Reader
    ALLOWED_METHODS = %i[get post put delete].freeze

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
      routes.merge!({ path => { method.upcase =>
        { controller: hash[:to][:controller], action: hash[:to][:action] } } })
    end
  end
end
