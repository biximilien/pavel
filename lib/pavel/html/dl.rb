class Pavel::HTML::DL < Pavel::HTML::Element
  def remove
    @div ||= @document.css('dl#gcwu-date-mod').first

    if @div
      @div.remove
    end

    self
  end
end
