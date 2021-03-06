ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
  set :database, {adapter: "sqlite3", database: "db/gradebook.sqlite3"}
end

require './app/controllers/application_controller'
require_all 'app'