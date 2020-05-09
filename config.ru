require 'bundler'
Bundler.require

require './app'

# セッションはまだないから除外しておく
use Rack::Protection, :except => [:remote_token, :session_hijacking]
run Copper.new