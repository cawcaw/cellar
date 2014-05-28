require 'sinatra/base'
require 'pg'
require 'sequel'
require 'mustache'
require 'yaml'
require 'json'
require 'warden'
require 'bcrypt'

module Cellar
  class << self
    def path_lib
      File.expand_path '../cellar', __FILE__
    end
    def path(dir = '')
      File.join path_lib, dir
    end
    def read_yaml(name)
      yaml_file = File.join(APP_PATH, name)
      if File.exist? yaml_file
        YAML.load_file(yaml_file)
      else
        p "#{name} not exist!"
        nil
      end
    end
    @@config = Cellar.read_yaml 'config/cellar.yml'
    def config() @@config end
  end

  class Base < Sinatra::Base
    enable :sessions
    set :static, true

    private
    def production?
      settings.environment == :production
    end
  end
end

require Cellar.path('environment')
require Cellar.path('warden')
require Cellar.path('base_controller')
require Cellar.path('render')

Dir.glob(Cellar.path('views/*.rb'), &method(:require))

