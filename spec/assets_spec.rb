require File.expand_path('spec_helper', File.dirname(__FILE__))

describe App do
  context 'Stylesheet' do
    it 'style.css' do
      get test_dev('/assets/style.css')
      expect(last_response).to be_ok
      expect(last_response.body).to include('.stylesheet.test.ok')
    end
    it 'bad.css' do
      get test_dev('/assets/bad.css')
      expect(last_response.status).to eq(404)
      expect(last_response.body).to_not include('.stylesheet.test.ok')
    end
  end
end

