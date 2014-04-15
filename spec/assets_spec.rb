require File.expand_path('spec_helper', File.dirname(__FILE__))

describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  before(:all) do
    Sequel.extension :migration
    Sequel::Migrator.apply App::DB, Cellar.path('db/migrations'), -1
    Sequel::Migrator.apply App::DB, Cellar.path('db/migrations')
    test_site = Site.new
    test_site.name = 'test'
    test_site.domain = 'localhost'
    test_site.save
  end

  context 'Stylesheet' do
    it 'style.css' do
      get '/assets/style.css'
      expect(last_response).to be_ok
      expect(last_response.body).to include('.stylesheet.test.ok')
    end
    it 'bad.css' do
      get '/assets/bad.css'
      expect(last_response.status).to eq(404)
      expect(last_response.body).to_not include('.stylesheet.test.ok')
    end
  end
end

