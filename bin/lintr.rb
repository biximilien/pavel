#!/usr/bin/env ruby
# pavellintr.rb

# Add lib to load paths
lib = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(lib) if File.directory?(lib) && !$LOAD_PATH.include?(lib)

# Require from gemfile and lib
require 'rubygems'
require 'bundler/setup'
require 'pavel'

Pavel.configure do |config|

end

include Pavel::Linter

puts "[ PAVELLINTR ] - Starting... \n\n"

begin

  Pavel::Directory.temp.clean
  Pavel::Directory.target.clean

  """
    PHASE 1 Build temporary distribution and removes unnecessary layout
  """

  puts "[ PAVELLINTR ] - Processing stage 1... \n\n"

  Dir.glob(Pavel::Directory.source.path + "/**/*.{#{Pavel[:extensions]}}") do |filename|
    next if File.basename(filename) == 'pf-if-pub.html'
    case filename

    # When HTML files
    when /\.(?:html|htm)$/i

      print "Processing #{filename}..."

      document = get_html_document(filename, Pavel[:source][:encoding])

      process_html(document)

      puts " Done."

      # Make directory
      temp_filename = filename.gsub(Pavel::Directory.source.path, Pavel::Directory.temp.path)

      make_directory_if_not_exist(temp_filename)

      # Save changes in temp dir
      print "Writing #{temp_filename}..."

      write_html_document(document, temp_filename, Pavel[:temp][:encoding])

      puts " Done."

    # When not HTML files
    else


      temp_filename = filename.gsub(Pavel::Directory.source.path, Pavel::Directory.temp.path)

      make_directory_if_not_exist(temp_filename)

      copy_file(filename, temp_filename)


    end
  end

  """
    PHASE 2 : Locate core files
  """

  puts "[ PAVELLINTR ] - Processing stage 2... \n\n"

  root = Pavel::Directory.temp.path + '/btb66a0.html'
  visited = []
  queue = []

  traverse(queue, visited, root)

  """
    PHASE 3 : Copy core files to dist
  """

  puts "[ PAVELLINTR ] - Processing stage 3... \n\n"

  copy_files(visited, Pavel::Directory.temp.path, Pavel::Directory.target.path)

rescue StandardError => e

  puts "[ PAVELLINTR ] - Something went wrong! \n\n"

  puts e.backtrace

  raise

ensure

  puts "[ PAVELLINTR ] - Cleaning temp files... \n\n"

  Pavel::Directory.temp.clean

end

puts "[ PAVELLINTR ] - Terminating."

exit
