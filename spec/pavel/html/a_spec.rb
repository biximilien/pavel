require 'spec_helper'

RSpec.describe Pavel::HTML::A do
  TEMP_FILE = 'tmp/mock.html'

  # Create mock file before testing
  before(:all) do
    File.write(TEMP_FILE, <<-END_HTML)
      <!DOCTYPE html>
      <html>
        <head>
        </head>
        <body>

        </body>
      </html>
    END_HTML

    @document = Nokogiri::HTML(open(TEMP_FILE))
  end

  # Setup subject
  before(:each) do
    @a = Pavel::HTML::A.new(@document)
  end

  # Test footer content removal
  describe "#remove_domains" do
    it "removes the footer content and children" do
      @a.remove_domains
      skip
    end
  end

  # Clean up after all tests are done
  after(:all) do
    File.delete(TEMP_FILE)
  end
end
