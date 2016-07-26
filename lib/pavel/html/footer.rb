module Pavel
  module HTML
    class Footer
      attr_accessor :document

      def initialize(document)
        @document = document
      end

      def remove
        @footer ||= @document.css('footer').first

        if @footer
          @footer.content = ''
          if @footer.children
            @footer.children.remove
          end
        end

        self
      end

    end
  end
end
