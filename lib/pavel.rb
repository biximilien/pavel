require 'fileutils'
require 'nokogiri'
require 'uri'

module Pavel
  autoload :Linter,        'pavel/linter'
  autoload :Directory,     'pavel/directory'
  autoload :Configuration, 'pavel/configuration'

  module HTML
    autoload :Element,     'pavel/html/element'
    autoload :Header,      'pavel/html/header'
    autoload :Footer,      'pavel/html/footer'
    autoload :A,           'pavel/html/a'
    autoload :Div,         'pavel/html/div'
    autoload :Nav,         'pavel/html/nav'
    autoload :H1,          'pavel/html/h1'
    autoload :Title,       'pavel/html/title'
    autoload :Comment,     'pavel/html/comment'
    autoload :DL,          'pavel/html/dl'
    autoload :Fragment,    'pavel/html/fragment'
    autoload :Middle,      'pavel/html/middle'
    autoload :Body,        'pavel/html/body'
    autoload :Head,        'pavel/html/head'
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  def self.[] attribute
    @configuration[attribute]
  end

end
