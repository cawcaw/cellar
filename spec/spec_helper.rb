ENV['RACK_ENV'] ||= 'test'
TEST_APP = File.expand_path('testapp', File.dirname(__FILE__))
require 'bundler/setup'
require 'rack/test'
require File.join(TEST_APP, 'boot')

include Rack::Test::Methods

def app
  App.new
end

def test_dev(uri)
  "http://test.dev#{uri}"
end

Rspec.configure do |config|
  config.around(:each) do |example|
    App::DB.transaction(rollback: :always){ example.run }
  end
  config.before(:all) do
    Sequel.extension :migration
    Sequel::Migrator.apply App::DB, Cellar.path('db/migrations'), 0
    Sequel::Migrator.apply App::DB, Cellar.path('db/migrations')
    load File.join(TEST_APP, 'seed.rb')
  end
end

