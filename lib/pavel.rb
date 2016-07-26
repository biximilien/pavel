require 'fileutils'
require 'nokogiri'
require 'uri'

module Pavel
  autoload :Directory, 'pavel/directory'

  module HTML
    autoload :Footer, 'pavel/html/footer'
    autoload :A, 'pavel/html/a.rb'
  end

  class << self
    def source
      { path: 'pavel/src/www.bt-tb.tpsgc-pwgsc.gc.ca',
        encoding: 'ISO-8859-1' }
    end

    def target
      { path: 'pavel/dist',
        encoding: 'UTF-8' }
    end
  end

end
