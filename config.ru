require 'sinatra/base'
require './config.rb'

map '/' do
  run App
end
