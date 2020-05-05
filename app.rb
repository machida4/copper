# frozen_string_literal: true

require 'rack'
require 'haml'
require 'pathname'
require 'yaml'

Pathname(__dir__).glob('lib/**/*.rb').each(&method(:require))
Pathname(__dir__).glob('app/**/*.rb').each(&method(:require))

class Copper
  attr_reader :rom_conf

  def initialize
    db_setup()
  end

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

  private

  def db_setup
    config_read = YAML.load(db_config_file.read)
    @rom_conf = ROM::Configuration.new(:sql, config_read.dig('database', 'path'))
  end

  def db_config_file
    Pathname(__dir__).join('config', 'database.yml')
  end
end
