require 'rack'
require 'pathname'
Pathname(__dir__).glob('lib/**/*.rb').each(&method(:require))
Pathname(__dir__).glob('app/**/*.rb').each(&method(:require))

class Copper
  def self.root
    Pathname(__dir__)
  end

  def call(env)
    req = ::Rack::Request.new(env)
    controller = ::Routing::Router.new.process(req)
    res = ::Rack::Response.new { |r|
      r.status = controller.status
      r['Content-Type'] = 'text/html;charset=utf-8'
      r.write controller.body
    }
    res.finish
  end
end
