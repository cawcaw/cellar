module Cellar
  class Base
    get '/assets/:asset' do
      request_file, request_extension = params[:asset].split('.')
      file = File.join(@site_assets, request_file)
      case request_extension
      when 'css'
        response = ''
        CELLAR_CSS_TEMPLATES.each do |extension|
          if File.exist? "#{file}.#{extension}"
            response = send(extension, open("#{file}.#{extension}").read)
          end
        end
        ## TODO
        ## precompile
        # if ENV["RACK_ENV"] == 'development'
        #   File.open(File.join(@site_root, "public/assets/#{request_file}.css"), 'w').write response
        # end
        if response == ''
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
