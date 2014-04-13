module Cellar
  class Base
    def render_layout(body)
      instance = Views::Layout.new
      instance.template_file = template_path 'layout'
      instance[:yield] = body
      instance.render
    end
    def render_page(template, locales)
      instance = Views::Page.new locales
      instance.template_file = template_path template
      render_layout instance.render
    end
    def template_path(name)
      File.join @site_root, "templates/#{name}.mustache"
    end
    def template_exist?(template)
      File.exist? template_path(template)
    end

    def html(source)
      source
    end
    def css(source)
      source
    end
  end
end

