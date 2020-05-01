# frozen_string_literal: true

require 'rack'
require 'haml'
require 'pathname'

Pathname(__dir__).glob('lib/**/*.rb').each(&method(:require))
Pathname(__dir__).glob('app/**/*.rb').each(&method(:require))

class Copper
  def self.root
    Pathname(__dir__)
  end

  def call(env)
    req = ::Rack::Request.new(env)
    ctr = ::Routing::Router.new(req).process
    res = ::Rack::Response.new do |r|
      r.status = ctr.status
      r['Content-Type'] = 'text/html;charset=utf-8'
      r.write(ctr.body)
    end

    res.finish
  end
end
