module Cellar
  module Views
    class Layout < Mustache
      def partial(name)
        File.read("#{template_path}/_#{name}.#{template_extension}")
      end

      attr_accessor :site

      def title
        @site[:title] || @site[:name] unless @site.nil?
      end

      def styles
        styles_set = []
        unless @site.nil?
          Dir[@site.assets('styles/*.*')].each do |stylesheet|
            style_file = File.basename stylesheet, '.*'
            next if style_file[0] == '_'
            styles_set << "<link rel='stylesheet' href='/assets/#{style_file}.css'>"
          end
        end
        styles_set.join "\n"
      end

      def admin?
        false
      end
    end
  end
end
