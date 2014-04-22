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
    end
    it 'common.js' do
      get test_dev('/assets/common.js')
      expect(last_response).to be_ok
      expect(last_response.body).to include('javascript test ok')
    end
    it 'bad.js' do
      get test_dev('/assets/bad.js')
      expect(last_response.status).to eq(404)
    end
  end
end

