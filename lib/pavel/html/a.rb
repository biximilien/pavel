class Pavel::HTML::A < Pavel::HTML::Element
  def remove_domains
    @document.css('a').each do |link|
      begin
        if link.attribute('rel').to_s != 'external'
          next if link.attribute('href').nil? || link.attribute('href').to_s.empty?
          prev_href = link.attribute('href').to_s
          uri = URI.parse(link.attribute('href').to_s)
          link.attribute('href').value = uri_without_domain(uri)
        else
          link.content = '[REMOVED]'
          link.attribute('href').value = '#'
        end
      rescue URI::InvalidURIError
        if link.attribute('rel').to_s != 'external'
          next if link.attribute('href').nil? || link.attribute('href').to_s.empty?
          prev_href = link.attribute('href').to_s
          uri = URI.parse(URI.encode(link.attribute('href').to_s))
          link.attribute('href').value = uri_without_domain(uri)
        else
          link.content = '[REMOVED]'
          link.attribute('href').value = '#'
        end
      end
    end

    self
  end

  private

    def uri_without_domain(uri)
      "#{uri.path}#{uri.query ? "?#{uri.query}" : ''}#{uri.fragment ? "##{uri.fragment}" : ''}"
    end

end
