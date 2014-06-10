require File.expand_path('spec_helper', File.dirname(__FILE__))

describe App do
  context 'Nodes' do
    context 'with valid template' do
      it 'and with db record' do
        get test_dev('/news/new-1')
        expect(last_response).to be_ok
        expect(last_response.body).to include('new content')
      end
    end
    context 'without (with lost) template' do
      it 'but with db record' do
        get test_dev('/sales/mega-discount')
        expect(last_response.status).to eq(500)
      end
      it 'and without db record' do
        get test_dev('/news/new-2')
        expect(last_response.status).to eq(404)
        expect(last_response.body).to include('page not found')
      end
    end
    context 'after loading to db' do
      it 'check count' do
        expect(Cellar::Node.all.size).to eq(4)
      end
    end
  end
end

