module Cellar
  class Base
    before do
      @current_site = Site['localhost']
      @site_root = File.join APP_PATH, "sites/#{@current_site.name.downcase}"
      @site_templates = File.join @site_root, 'templates'
      @site_assets = File.join @site_root, 'assets'
    end
  end
end

Dir.glob(Cellar.path('controllers/*.rb'), &method(:require))

