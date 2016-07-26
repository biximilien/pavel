class Pavel::HTML::Nav < Pavel::HTML::Element

  def remove
    @nav ||= @document.css('nav').first

    if @nav
      @nav.remove
    end

    self
  end

end
