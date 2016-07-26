class Pavel::HTML::H1 < Pavel::HTML::Element

  def remove
    @h1 ||= @document.css('h1').first

    if @h1 && @h1.children
      if @h1.children.first.text =~ /archived|archivée/i
        @h1.children.first.remove
      end
    end

    self
  end

end
