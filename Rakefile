# Rakefile

lib = File.expand_path(File.dirname(__FILE__) + '/lib')
$LOAD_PATH.unshift(lib) if File.directory?(lib) && !$LOAD_PATH.include?(lib)

require 'rubygems'
require 'bundler/setup'
require 'pavel'

task :default => [:build, :rspec]

desc "Builds distribution"
task :build do
  puts "Building distribution..."
  # Pavel.build
  puts "Done."
end

desc "Alias of rspec"
task :spec => :rspec

desc "Alias of rspec"
task :test => :rspec

desc "Runs tests on distribution"
task :rspec do
  require 'rspec'
  puts "Testing distribution..."
  Dir.glob(Pavel.target[:path] + '/**/*.html') do |file|
    RSpec.describe file do
      document = Nokogiri::HTML(open(file))

      it "links to existing resources" do
        document.css('a').each do |link|
          if link.attribute('rel').to_s != 'external'
            expect(File.exist?(Pavel.target[:path] + URI.parse(link.attribute('href').to_s).path)).to be true
          end
        end
      end
    end
  end
  puts "Done."
end
