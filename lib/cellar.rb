require 'sinatra/base'
require 'pg'
require 'sequel'
require 'yaml'
require 'json'

CELLAR_HTML_TEMPLATES = %w(html mustache)
require 'mustache'

CELLAR_CSS_TEMPLATES = %w(css sass scss)
require 'sass'

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
  end
end

require Cellar.path('environment')
require Cellar.path('base_controller')
require Cellar.path('render')

Dir.glob(Cellar.path('views/*.rb'), &method(:require))

