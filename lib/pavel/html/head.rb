class Pavel::HTML::Head < Pavel::HTML::Element
  def insert_after(fragment)
    @head ||= @document.css('head').first

    if @head
      @head.children.after(fragment)
    end

    self
  end
end
