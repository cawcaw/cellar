module Cellar
  class Base
    get '/assets/:asset' do
      asset_name, extension = params[:asset].split('.')
      case extension
      when 'css'
        response = render_style asset_name
        if response.nil?
          status 404
          'style not found'
        else
          response
        end
      else
        pass
      end
    end
  end
end
