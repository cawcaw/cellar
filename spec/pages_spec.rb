require File.expand_path('spec_helper', File.dirname(__FILE__))

describe App do
  context 'Pages' do
    context 'with valid template' do
      it 'but without db record' do
        get test_dev('/about')
        expect(last_response).to be_ok
        expect(last_response.body).to include('<h1>independent template</h1>')
      end
      it 'and with db record' do
        get test_dev('/page1')
        expect(last_response).to be_ok
        expect(last_response.body).to include('<p>text content</p>')
      end
    end
    context 'without (with lost) template' do
      it 'but with db record' do
        get test_dev('/page2')
        expect(last_response.status).to eq(500)
      end
      it 'and without db record' do
        get test_dev('/abyrvalg')
        expect(last_response.status).to eq(404)
        expect(last_response.body).to include('page not found')
      end
    end
    it 'with partial' do
      get test_dev('/partial')
      expect(last_response).to be_ok
      expect(last_response.body).to include('<p>this partial</p>')
    end
  end
end

