require 'spec_helper'

RSpec.describe Pavel::HTML::Footer do
  TEMP_FILE = 'tmp/mock.html'

  # Create mock file before testing
  before(:all) do
    File.write(TEMP_FILE, <<-END_HTML)
      <!DOCTYPE html>
      <html>
        <head>
        </head>
        <body>
          <footer>
            #{FFaker::Lorem.paragraph}
            <h1>#{FFaker::Lorem.sentence}</h1>
            <p>#{FFaker::Lorem.paragraph}</p>
            <ul>
              <li>#{FFaker::Lorem.sentence}</li>
              <li>#{FFaker::Lorem.sentence}</li>
              <li>#{FFaker::Lorem.sentence}</li>
            </ul>
          </footer>
        </body>
      </html>
    END_HTML

    @document = Nokogiri::HTML(open(TEMP_FILE))
  end

  # Setup subject
  before(:each) do
    @footer = Pavel::HTML::Footer.new(@document)
  end

  # Test footer content removal
  describe "#remove" do
    it "removes the footer content and children" do
      @footer.remove
      expect(@footer.document.css('footer').first.content).to be_empty
      expect(@footer.document.css('footer').first.children).to be_empty
    end
  end

  # Clean up after all tests are done
  after(:all) do
    File.delete(TEMP_FILE)
  end
end
