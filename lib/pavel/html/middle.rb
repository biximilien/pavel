class Pavel::HTML::Middle < Pavel::HTML::Fragment
  def replace(fragment)
    @middle ||= @fragment
    # @middle ||= @fragment.at_css("div#main-content-replacer")

    if @middle
      @middle.replace(fragment)
    end

    self
  end
end
