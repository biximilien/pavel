class Pavel::HTML::Title < Pavel::HTML::Element

  def remove
    @title ||= @document.css('title').first

    if @title
      # if @title.text =~ /archived|archivée/i
      #   begin
      #     @title.content = @title.text.to_s.strip.gsub($~.to_s, '')
      #   rescue ArgumentError
      #     @title.content = @document.css('h1').first.text
      #   end
      # end
      @title.content = 'Pavel'
    end

    self
  end

end
