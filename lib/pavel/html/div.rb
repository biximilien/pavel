class Pavel::HTML::Div < Pavel::HTML::Element

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  class WBSkip < Pavel::HTML::Div
    def remove
      @div ||= @document.css('div#wb-skip').first

      if @div
        @div.remove
      end

      self
    end
  end

  class WBHead < Pavel::HTML::Div
    def remove
      @div ||= @document.css('div#wb-head').first

      if @div
        @div.remove
      end

      self
    end
  end

  class WBSec < Pavel::HTML::Div
    def remove
      @div ||= @document.css('div#wb-sec').first

      if @div
        @div.remove
      end

      self
    end
  end

  class Archived < Pavel::HTML::Div
    def remove
      @div ||= @document.css('div#archived').first

      if @div
        @div.remove
      end

      self
    end
  end

  class WBFoot < Pavel::HTML::Div
    def remove
      @div ||= @document.css('div#wb-foot').first

      if @div
        @div.remove
      end

      self
    end
  end

  class WBMainIn < Pavel::HTML::Div
    def remove
      @div ||= @document.css('div#wb-main-in').first
      @body ||= @document.css('body').first

      if @div
        @div.parent = @body
        @div.attributes['id'].value = 'body'
      end

      self
    end
  end

end
