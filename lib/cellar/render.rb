module Cellar
  class Base
    private
    def render_page(template, locales = {})
      instance = Views::Page.new locales
      instance.template_path = @site.templates
      instance.template_file = template_path template
      instance.request = request
      instance.site = @site
      instance.user = @user
      locales.delete "content"
      if request.xhr?
        instance.render locales
      else
        locales.merge! auto_load_data
        body = instance.render locales
        instance.template_file = template_path 'layout'
        instance[:yield] = body
        instance.render locales
      end
    end

    def template_path(name)
      if File.exist? file =  File.join(@site.templates, "#{name}.mustache")
        file
      elsif File.exist? file = Cellar.path("templates/#{name}.mustache")
        file
      else
        false
      end
    end

    def template_exist?(template)
      template_path(template) != false
    end

    def render_style(name)
      return File.read(Cellar.path('assets/cellar.css')) if name == 'cellar'
      return unless file = Dir[@site.assets("stylesheets/#{name}.*")][0]
      case ext = file.split('.').last
      when 'scss', 'sass'
        return unless defined? Sass
        options = {
          load_paths: [@site.assets('stylesheets')],
          syntax: ext.to_sym
        }
        Sass::Engine.new(File.read(file), options).render
      when 'less'
        return unless defined? Less
        less = Less::Parser.new(paths: [@site.assets('stylesheets')])
        less.parse(File.read(file)).to_css compress: production?
      when 'css'
        File.read(file)
      end
    end

    def render_js(name)
      return File.read(Cellar.path('assets/cellar.js')) if name == 'cellar'
      return unless file = Dir[@site.assets("javascripts/#{name}.*")][0]
      case ext = file.split('.').last
      when 'coffee'
        return unless defined? CoffeeScript
        CoffeeScript.compile File.read(file)
      when 'js'
        File.read(file)
      end
    end

    def auto_load_data
      loaded = {}
      @site.node_types_dataset.where('auto_load > 0').each do |t|
        loaded[:"auto_#{t.name}s"] =
          @site.nodes_dataset.where(type: t.name).limit(t.auto_load).
          all.map { |node| node.data }
      end
      # TODO records
      loaded
    end
  end
end

