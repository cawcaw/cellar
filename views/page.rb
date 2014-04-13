module Cellar
  module Views
    class Page < Layout
      @content = []
      def content
        @content[0]
      end
      def initialize(content)
        @content = content
        if content.is_a?(Array) && content.size > 1
          content.size.times do |index|
            instance_eval  "def content#{index}; @content[#{index}]; end"
          end
        end
      end
    end
  end
end
