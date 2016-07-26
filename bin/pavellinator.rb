#!/usr/bin/env ruby
# pavellinator.rb

lib = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(lib) if File.directory?(lib) && !$LOAD_PATH.include?(lib)

require 'rubygems'
require 'bundler/setup'
require 'pavel'

# root = Pavel.target[:path] + '/btb66a0.html'
# visited = []
# queue = []
#
# document = Nokogiri::HTML(open(root))
# visited.push root
#
# document.css('a').each do |link|
#   filename = "#{Pavel.target[:path]}/#{URI.parse(link.attribute('href').to_s).path}"
#   queue.push(filename) if File.exist?(filename) && !visited.include?(filename) && !queue.include?(filename)
# end
#
# while queue.length > 0
#   filename = queue.pop
#
#   document = Nokogiri::HTML(open(filename))
#   visited.push(filename) if !visited.include?(filename)
#
#   document.css('a').each do |link|
#     filename = "#{Pavel.target[:path]}/#{URI.parse(link.attribute('href').to_s).path}"
#     queue.push(filename) if File.exist?(filename) && !visited.include?(filename) && !queue.include?(filename)
#   end
# end
#
# puts "Visited length: #{visited.length}"
# puts "Queue length: #{queue.length}"
#
# puts Dir.glob(Pavel.target[:path] + '/**/*.html') - visited
#
# exit

puts "[ PAVELLINATOR ] - Starting..."
Dir.glob(Pavel.source[:path] + "/**/*.{html,ico,css,eot,gif,jpg,js,mp4,pdf,png,ttf,woff,xml}") do |filename|
  case filename

  # When HTML files
  when /\.(?:html|htm)$/i

    print "Processing #{filename}..."
    document = ''
    File.open filename, "r:#{Pavel.source[:encoding]}" do |file|
      document = Nokogiri::HTML(file, nil, Pavel.source[:encoding])
    end

    # Remove comments
    comment = Pavel::HTML::Comment.new(document)
    comment.remove

    # Remove title
    title = Pavel::HTML::Title.new(document)
    title.remove

    # Remove header
    header = Pavel::HTML::Header.new(document)
    header.remove

    # Remove unnecessary divs
    Pavel::HTML::Div.descendants.each do |descendant|
      element = descendant.new(document)
      element.remove
    end

    # Remove nav
    nav = Pavel::HTML::Nav.new(document)
    nav.remove

    # Remove footer
    footer = Pavel::HTML::Footer.new(document)
    footer.remove

    # Remove archived from h1
    h1 = Pavel::HTML::H1.new(document)
    h1.remove

    # Remove gov't domain from links
    a = Pavel::HTML::A.new(document)
    a.remove_domains

    # Remove modification date
    dl = Pavel::HTML::DL.new(document)
    dl.remove

    puts " Done."

    # Make directory
    temp_filename = filename.gsub(Pavel.source[:path], Pavel.target[:path])
    dirname = File.dirname(temp_filename)
    unless File.directory?(dirname)
      print "Creating directory: #{dirname}..."
      FileUtils.mkdir_p(dirname)
      puts " Done."
    end

    # Save changes in temp dir
    print "Writing #{temp_filename}..."
    File.open temp_filename, "w:#{Pavel.target[:encoding]}" do |file|
      file.write(document.to_html)
    end
    puts " Done."

  # When not HTML files
  else

    # Make directory
    temp_filename = filename.gsub(Pavel.source[:path], Pavel.target[:path])
    dirname = File.dirname(temp_filename)
    unless File.directory?(dirname)
      print "Creating directory: #{dirname}..."
      FileUtils.mkdir_p(dirname)
      puts " Done."
    end

    print "Copying #{filename}..."
    FileUtils.cp(filename, temp_filename)
    puts " Done."

  end
end
