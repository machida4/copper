require 'rack'
require 'pathname'

Pathname(__dir__).glob('lib/**/*.rb').each(&method(:require))
Pathname(__dir__).glob('app/**/*.rb').each(&method(:require))

class Copper
  def self.root
    Pathname(__dir__)
  end

  def call(env)
    req = ::Request.new(env)
    res = ::Processing::Processor.new(req).process
    res.finish
  end
end
