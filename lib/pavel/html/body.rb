class Pavel::HTML::Body < Pavel::HTML::Element

  # def replace(fragment)
  #   @body ||= @document.css('body').first
  #
  #   if @body
  #     @body.replace(fragment)
  #   end
  #
  #   self
  # end

  def insert_before(fragment)
    @body ||= @document.css('body').first

    if @body
      @body.children.before(fragment)
    end

    self
  end

  def insert_after(fragment)
    @body ||= @document.css('body').first

    if @body
      @body.children.after(fragment)
    end

    self
  end

end
