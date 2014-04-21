module Cellar
  module Views
    class Layout < Mustache
      def partial(name)
        File.read("#{template_path}/_#{name}.#{template_extension}")
      end

      def title
        'CJSC Svet'
      end

      def styles
        '<link rel="stylesheet" href="/assets/style.css">'
      end

      def admin?
        false
      end
    end
  end
end
