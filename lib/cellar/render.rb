module Cellar
  class Base
    def render_layout(body)
      instance = Views::Layout.new
      instance.template_path = @site.templates
      instance.template_file = template_path 'layout'
      instance.site = @site
      instance[:yield] = body
      instance.render
    end

    def render_page(template, locales)
      instance = Views::Page.new locales
      instance.template_path = @site.templates
      instance.template_file = template_path template
      instance.site = @site
      render_layout instance.render
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
      return unless file = Dir[@site.assets("styles/#{name}.*")][0]
      content_type 'text/css'
      case ext = file.split('.').last
      when 'scss', 'sass'
        options = {
          load_paths: [@site.assets('styles')],
          syntax: ext.to_sym
        }
        Sass::Engine.new(File.read(file), options).render
      when 'css'
        File.read(file)
      end
    end
  end
end

