require 'sinatra/base'
require 'pg'
require 'sequel'
require 'mustache'
require 'yaml'
require 'json'

module Cellar
  class << self
    def path_lib
      File.expand_path '../cellar', __FILE__
    end
    def path(dir = '')
      File.join path_lib, dir
    end
  end

  class Base < Sinatra::Base
    enable :sessions

    private
    def production?
      settings.environment == :production
    end
  end
end

require Cellar.path('environment')
require Cellar.path('base_controller')
require Cellar.path('render')

Dir.glob(Cellar.path('views/*.rb'), &method(:require))

