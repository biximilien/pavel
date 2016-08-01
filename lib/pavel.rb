require 'fileutils'
require 'nokogiri'
require 'uri'

module Pavel
  autoload :Linator,   'pavel/linator'
  autoload :Directory, 'pavel/directory'

  module HTML
    autoload :Element, 'pavel/html/element'
    autoload :Header,  'pavel/html/header'
    autoload :Footer,  'pavel/html/footer'
    autoload :A,       'pavel/html/a'
    autoload :Div,     'pavel/html/div'
    autoload :Nav,     'pavel/html/nav'
    autoload :H1,      'pavel/html/h1'
    autoload :Title,   'pavel/html/title'
    autoload :Comment, 'pavel/html/comment'
    autoload :DL,      'pavel/html/dl'
  end

  class << self
    def source
      { path: 'pavel/src/www.bt-tb.tpsgc-pwgsc.gc.ca',
        encoding: 'UTF-8' }
    end

    def temp
      { path: 'pavel/temp',
        encoding: 'UTF-8' }
    end

    def target
      { path: 'pavel/dist',
        encoding: 'UTF-8' }
    end

    def verbose
      false
    end
  end

end
