require File.expand_path('spec_helper', File.dirname(__FILE__))

describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  before(:all) do
    %x(dropdb cellar_test)
    %x(createdb cellar_test -E UTF8 -h localhost)

    Sequel.extension :migration
    Sequel::Migrator.apply App::DB, Cellar.path('db/migrations'), -1
    Sequel::Migrator.apply App::DB, Cellar.path('db/migrations')
    test_site = App::Site.new
    test_site.name = 'test'
    test_site.domain = 'localhost'
    test_site.save
  end

  context 'Stylesheet' do
    it 'style.css' do
      get '/assets/style.css'
      expect(last_response).to be_ok
      expect(last_response.body).to include('stylesheet')
    end
  end
end

