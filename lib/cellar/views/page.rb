module Cellar
  module Views
    class Page < Layout
      @content = []
      @locales = {}

      def content
        content_1 unless @content[0].nil?
      end

      def can_edit?
        admin?
      end

      def initialize(locales = {})
        @locales = locales
        @content = @locales[:content]
        @content.size.times do |index|
          instance_eval  "def content_#{index+1};"\
            " editable @content[#{index}], #{index}; end"
        end
      end

      def title
        @locales[:title] || super
      end

      def editable(content, index=0)
        if admin?
        "<div class='c-editable' data-slug='#{@locales[:slug]}'"\
          " data-content-index='#{index}'>"\
          "#{content}</div>"
        else
          content
        end
      end
    end
  end
end
