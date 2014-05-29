module Cellar
  class Base
    before do
      if settings.development?
        @site = Site.last
      else
        @site = Site[domain: request.host]
      end
      @user = env['warden'].user
      if @user
        @user = Cellar::User.guest unless @user.site_id == @site.id
      end
      @path = request.path_info
      settings.public_folder = File.join @site.root_path, 'public'
    end
  end
end

require Cellar.path('controllers/session_controller.rb')
require Cellar.path('controllers/assets_controller.rb')
require Cellar.path('controllers/pages_controller.rb')

