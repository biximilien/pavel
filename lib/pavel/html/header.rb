class Pavel::HTML::Header < Pavel::HTML::Element

  def remove
    @header ||= @document.css('header').first

    if @header
      @header.content = ''
      if @header.children
        @header.children.remove
      end
    end

    self
  end

end
