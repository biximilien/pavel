class Pavel::HTML::Footer < Pavel::HTML::Element

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
