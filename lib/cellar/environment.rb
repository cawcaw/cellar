module Cellar
  class Base
    config = YAML.load_file('config/database.yml')

    %w(development production test).each do |env|
      configure env.to_sym do
        set :environment, env.to_sym
        DB = Sequel.connect(config[env])
        DB.extension :pg_array
      end
    end
  end

  Dir.glob(Cellar.path('models/*.rb'), &method(:require))
end

