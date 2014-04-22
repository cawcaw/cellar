module Cellar
  class Base
    get '/assets/:asset' do |asset|
      pass unless asset.include? '.'
      asset_name, extension = asset.split('.')
      response = case extension
      when 'css'
        content_type 'text/css'
        render_style asset_name
      when 'js'
        content_type 'text/javascript'
        render_js asset_name
      end
      if response
        response
      else
        status 404
        'asset lost'
      end
    end
  end
end
