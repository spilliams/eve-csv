require 'rubygems'
require 'bundler/setup'
Bundler.require
base = File.expand_path(File.dirname(__FILE__))
require File.join base, 'app.rb'
# require File.join base, 'app_helpers.rb'

Sinatra::Base.set :root, 		base 
Sinatra::Base.set :static, 	true
Sinatra::Base.set :show_exceptions, true
Sinatra::Base.set :views, 	Proc.new{ File.join(Sinatra::Base.root, "views") }
Sinatra::Base.set :session_secret, "I&YS!B7.TCJoQ6cvY!c9$zG@nU6l8J8u"
Sinatra::Base.enable :sessions

# for when we expand to use separate models
# Dir.glob( File.join(base, 'models', '*.rb')).each{|f| require f}
