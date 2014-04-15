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
    def root
      File.expand_path '../..', __FILE__
    end
    def path(dir = '')
      File.join root, dir
    end
  end

  class Base < Sinatra::Base
  end
end

require Cellar.path('lib/cellar/environment')
require Cellar.path('lib/cellar/base_controller')
require Cellar.path('lib/cellar/render')

Dir.glob(Cellar.path('views/*.rb'), &method(:require))

