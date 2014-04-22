module Cellar
  class Site < Sequel::Model
    one_to_many :pages

    def site_root
      File.join APP_PATH, "sites/#{name.downcase}"
    end

    def templates
      File.join site_root, 'templates'
    end

    def assets(*subdir)
      File.join site_root, 'assets', subdir
    end
  end
end

