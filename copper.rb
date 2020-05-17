require 'pathname'
require 'yaml'

Pathname(__dir__).glob('lib/**/*.rb').each(&method(:require))

# TODO: こんなところに書きとうないけど書かないとNameError出る、どうしたらいいの
config = YAML.load(Pathname(__dir__).join('config', 'database.yml').read)
DB = Sequel.connect(config)
Sequel.extension :migration
Sequel::Migrator.run(DB, Pathname(__dir__).join('app', 'db', 'migrations'))

Pathname(__dir__).glob('app/**/*.rb').each(&method(:require))

class Copper
  def self.root
    Pathname(__dir__)
  end

  # def initialize
  #   # TODO: DB関連も切り分けたい
  #   db_setup()
  #   Sequel::Migrator.run(@database, db_migrations_path)
  # end

  def call(env)
    req = ::Request.new(env)
    res = ::Processing::Processor.new(req).process
    res.finish
  end

  private

  # def db_setup
  #   raise NoConfigFileError unless db_config_path.exist?

  #   config = YAML.load(db_config_path.read)
  #   @database = Sequel.connect(config)
  #   Sequel.extension :migration
  # end

  # def db_config_path
  #   Copper.root.join('app', 'config', 'database.yml')
  # end

  # def db_migrations_path
  #   Copper.root.join('app', 'db', 'migrations')
  # end
end
