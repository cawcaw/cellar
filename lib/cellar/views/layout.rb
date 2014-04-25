module Cellar
  module Views
    class Layout < Mustache
      def partial(name)
        File.read("#{template_path}/_#{name}.#{template_extension}")
      end

      def cellar
        "<script src='//code.jquery.com/jquery-1.11.0.min.js'></script>\n"\
        "<script src='//code.jquery.com/jquery-migrate-1.2.1.min.js'></script>\n"\
        "<script src='/assets/cellar.js'></script>\n"\
        "<link rel='stylesheet' href='/assets/cellar.css'>"
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
