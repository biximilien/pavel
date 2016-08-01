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

  clean_temp_dir
  clean_target_dir

  """
    PHASE 1 Build temporary distribution and removes unnecessary layout
  """

  puts "[ PAVELLINATOR ] - Processing stage 1... \n\n"

  Dir.glob(Pavel.source[:path] + "/**/*.{#{Pavel.extensions}}") do |filename|
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

  traverse(queue, visited, root)

  """
    PHASE 3 : Copy core files to dist
  """

  puts "[ PAVELLINATOR ] - Processing stage 3... \n\n"

  copy_files(visited, Pavel.temp[:path], Pavel.target[:path])

rescue StandardError => e

  puts "[ PAVELLINATOR ] - Something went wrong! \n\n"

  puts e.backtrace

  raise

ensure

  puts "[ PAVELLINATOR ] - Cleaning temp files... \n\n"

  clean_temp_dir

end

puts "[ PAVELLINATOR ] - Terminating."

exit
