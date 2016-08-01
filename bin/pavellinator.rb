#!/usr/bin/env ruby
# pavellinator.rb

# Add lib to load paths
lib = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(lib) if File.directory?(lib) && !$LOAD_PATH.include?(lib)

# Require from gemfile and lib
require 'rubygems'
require 'bundler/setup'
require 'pavel'

include Pavel::Linator

puts "[ PAVELLINATOR ] - Starting... \n\n"
begin

  clean_target_dir

  """
    PHASE 1 Build temporary distribution and removes unnecessary layout
  """

  puts "[ PAVELLINATOR ] - Processing stage 1... \n\n"

  Dir.glob(Pavel.source[:path] + "/**/*.{html,ico,css,eot,gif,jpg,js,mp4,pdf,png,ttf,woff,xml}") do |filename|
    case filename

    # When HTML files
    when /\.(?:html|htm)$/i

      print "Processing #{filename}..."

      document = get_html_document(filename, Pavel.source[:encoding])

      process_html(document)

      puts " Done."

      # Make directory
      temp_filename = filename.gsub(Pavel.source[:path], Pavel.temp[:path])

      make_directory_if_not_exist(temp_filename)

      # Save changes in temp dir
      print "Writing #{temp_filename}..."

      write_html_document(document, temp_filename, Pavel.temp[:encoding])

      puts " Done."

    # When not HTML files
    else


      temp_filename = filename.gsub(Pavel.source[:path], Pavel.temp[:path])

      make_directory_if_not_exist(temp_filename)

      copy_file(filename, temp_filename)


    end
  end

  """
    PHASE 2 : Locate core files
  """

  puts "[ PAVELLINATOR ] - Processing stage 2... \n\n"

  root = Pavel.temp[:path] + '/btb66a0.html'
  visited = []
  queue = []

  document = Nokogiri::HTML(open(root))
  visited.push root

  document.css('a').each do |link|
    next if link.attribute('href').nil? || link.attribute('href').to_s.empty?
    filename = "#{Pavel.temp[:path]}/#{URI.parse(link.attribute('href').to_s).path}"
    queue.push(filename) if File.exist?(filename) && !visited.include?(filename) && !queue.include?(filename)
  end

  while queue.length > 0
    filename = queue.pop
    puts "Traversing #{filename}..."

    document = Nokogiri::HTML(open(filename))
    visited.push(filename) if !visited.include?(filename)

    document.css('a').each do |link|
      next if link.attribute('href').nil? || link.attribute('href').to_s.empty?
      filename = "#{Pavel.temp[:path]}/#{URI.parse(link.attribute('href').to_s).path}"
      queue.push(filename) if File.exist?(filename) && !visited.include?(filename) && !queue.include?(filename)
    end
  end

  """
    PHASE 3 : Copy core files to dist
  """

  puts "[ PAVELLINATOR ] - Processing stage 3... \n\n"

  copy_files(visited, Pavel.temp[:path], Pavel.target[:path])

rescue => error

  puts "[ PAVELLINATOR ] - Something went wrong! \n\n"

  puts error.backtrace

  puts "[ PAVELLINATOR ] - Terminating (ERROR 1)."

  exit 1

ensure

  puts "[ PAVELLINATOR ] - Cleaning temp files... \n\n"

  clean_temp_dir

end

puts "[ PAVELLINATOR ] - Terminating."

exit 0
