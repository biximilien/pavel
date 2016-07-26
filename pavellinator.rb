# pavellinator.rb
require_relative 'lib/pavel'

Dir.glob(Pavel.source[:path] + "/**/*.html") do |filename|
  # print "Converting #{filename}..."
  # content = ''
  #
  # File.open(filename, 'r') do |file|
  #   content = file.read.encode('ISO-8859-1', 'UTF-8')
  # end
  #
  # File.open(filename, 'w') do |file|
  #   file.write(content)
  # end
  #
  # puts " Done."

  # Parse HTML with nokogiri
  File.open filename, "r:#{Pavel.source[:encoding]}" do |file|
    document = Nokogiri::HTML(file, nil, Pavel.source[:encoding])
  end

  # Remove gov't domain from links
  a = Pavel::HTML::A.new(document)
  a.remove_domains

  # Remove footers
  footer = Pavel::HTML::Footer.new(file)
  footer.remove

  # Save changes
  File.open filename.gsub(Pavel.source[:path], Pavel.target[:path]), "w:#{Pavel.target[:encoding]}" do |file|
    file.write(document.to_html)
  end
end
