ENV['RACK_ENV'] ||= 'test'
require 'bundler/setup'
require 'rack/test'
require File.expand_path('testapp/boot', File.dirname(__FILE__))

# Rspec.configure do |config|
# end

