APP_PATH = File.dirname __FILE__
require 'bundler/setup'
Bundler.require(:default)
require File.join APP_PATH, 'app.rb'

