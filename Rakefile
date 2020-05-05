require 'bundler'
Bundler.require

require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    conf_map = YAML.load(Pathname(__dir__).join('config', 'database.yml').read)
    configuration = ROM::Configuration.new(:sql, conf_map.dig('database', 'path'))
    ROM::SQL::RakeSupport.env = configuration
  end
end