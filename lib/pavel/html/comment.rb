class Pavel::HTML::Comment < Pavel::HTML::Element

  def remove
    @comments ||= @document.xpath('//comment()').first
    @comments.remove if @comments

    self
  end

end
