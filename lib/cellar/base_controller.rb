module Cellar
  class Base
    before do
      @site = Site[domain: request.host]
      settings.public_folder = File.join @site.root_path, 'public'
    end
  end
end

Dir.glob(Cellar.path('controllers/*.rb'), &method(:require))

