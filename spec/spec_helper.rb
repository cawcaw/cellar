ENV['RACK_ENV'] ||= 'test'
TEST_APP = File.expand_path('../lib/cellar/template_app', File.dirname(__FILE__))
require 'bundler/setup'
require 'rack/test'
require File.join(TEST_APP, 'boot')
require 'sass'
require 'rake'
require File.expand_path('../lib/cellar/rake', File.dirname(__FILE__))

include Rack::Test::Methods

def app
  App.new
end

def test_dev(uri)
  "http://test.dev#{uri}"
end

RSpec.configure do |config|
  config.around(:each) do |example|
    App::DB.transaction(rollback: :always){ example.run }
  end
  config.before(:all) do
    Rake::Task['db:reset'].invoke
  end
end

