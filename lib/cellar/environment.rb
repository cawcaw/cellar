module Cellar
  class Base
    db_config = YAML.load_file(File.join(APP_PATH, 'config/database.yml'))

    %w(development production test).each do |env|
      configure env.to_sym do
        set :environment, env.to_sym
        DB = Sequel.connect(db_config[env])
        DB.extension :pg_array
      end
    end

    Dir.glob(Cellar.path('models/*.rb'), &method(:require))
  end
end

