module Cellar
  module Views
    class Layout < Mustache
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
