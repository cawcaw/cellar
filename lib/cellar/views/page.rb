module Cellar
  module Views
    class Page < Layout
      @content = []
      @locales = {}

      def content
        @content[0]
      end

      def initialize(locales = {})
        @locales = locales
        @content = @locales[:content]
        if @content.size > 1
          @content.size.times do |index|
            instance_eval  "def content#{index}; @content[#{index}]; end"
          end
        end
      end

      def title
        @locales[:title] || super
      end
    end
  end
end
