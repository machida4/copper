require 'rack'

class App
  def call(env)
    req = ::Rack::Request.new(env)
    res = ::Router.process(req)
    res.finish
  end
end
