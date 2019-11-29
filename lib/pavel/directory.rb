module Pavel
  class Directory
    attr_accessor :path

    def initialize(path)
      @path = path
    end

    def exist?
      File.directory?(@path)
    end

    def clean
      Dir.glob(@path + '/*') do |filename|
        FileUtils.rm_rf(filename, verbose: Pavel[:verbose])
      end
    end

    def self.source
      new(Pavel[:source][:path])
    end

    def self.temp
      new(Pavel[:temp][:path])
    end

    def self.target
      new(Pavel[:target][:path])
    end
  end
end
