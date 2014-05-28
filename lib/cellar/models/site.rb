module Cellar
  class Site < Sequel::Model
    one_to_many :pages
    one_to_many :users

    def root_path
      File.join APP_PATH, "sites/#{name.downcase}"
    end

    def templates
      File.join root_path, 'templates'
    end

    def assets(*subdir)
      File.join root_path, 'assets', subdir
    end
  end
end

