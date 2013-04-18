require 'bundler/setup'
Bundler.require(:default)

require 'sinatra/reloader'
require 'sinatra/json'
require 'pp'

Mongoid.load!('config/mongoid.yml')

require './ranking_app'
require './admin_app'

#run App
map '/rankings' do
  run RankingsApp
end

map '/' do
  run AdminApp
end
