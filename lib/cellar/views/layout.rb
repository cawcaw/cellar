module Cellar
  module Views
    class Layout < Mustache
      def partial(name)
        File.read("#{template_path}/_#{name}.#{template_extension}")
      end

      attr_accessor :site

      def title
        @site[:title] || @site[:name]
      end

      def stylesheets
        stylesheets_set = []
        Dir[@site.assets('stylesheets/*.*')].each do |stylesheet|
          basename = File.basename stylesheet, '.*'
          next if basename[0] == '_'
          stylesheets_set << "<link rel='stylesheet' href='/assets/#{basename}.css'>"
        end
        stylesheets_set.join "\n"
      end

      def javascripts
        javascripts_set = []
        Dir[@site.assets('javascripts/*.*')].each do |javascript|
          basename = File.basename javascript, '.*'
          next if basename[0] == '_'
          javascripts_set << "<script src='/assets/#{basename}.js'></script>"
        end
        javascripts_set.join "\n"
      end

      def admin?
        false
      end
    end
  end
end
