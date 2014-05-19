module Cellar
  class Base
    before do
      if settings.development?
        @site = Site.last
      else
        @site = Site[domain: request.host]
      end
      @path = request.path_info
      settings.public_folder = File.join @site.root_path, 'public'
    end
  end
end

Dir.glob(Cellar.path('controllers/*.rb'), &method(:require))

