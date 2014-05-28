module Cellar
  class Base
    db_config = Cellar.read_yaml 'config/database.yml'
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

