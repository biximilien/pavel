module Pavel
  class Configuration
    attr_accessor :source, :temp, :target, :verbose, :extensions, :resources_tags

    def initialize(
        source: { path: 'pavel/src/www.bt-tb.tpsgc-pwgsc.gc.ca',
                  encoding: 'UTF-8' },

        temp:   { path: 'pavel/temp',
                  encoding: 'UTF-8' },

        target: { path: 'pavel/dist',
                  encoding: 'UTF-8' },

        verbose: false,

        extensions: %w(html htm ico css eot gif jpg js mp4 pdf png ttf woff xml).join(','),

        resources_tags: %w(a script link img).join(','))

      self.source = source
      self.temp = temp
      self.target = target
      self.verbose = verbose
      self.extensions = extensions
      self.resources_tags = resources_tags
    end

    def [](attribute)
      raise ArgumentError if !(attribute.kind_of?(String) || attribute.kind_of?(Symbol))
      attribute = attribute.to_sym if !attribute.kind_of?(Symbol)
      self.send(attribute)
    end

    def []=(attribute, value)
      raise ArgumentError if !(attribute.kind_of?(String) || attribute.kind_of?(Symbol))
      attribute = attribute.to_sym if !attribute.kind_of?(Symbol)
      self.send(attribute, value)
    end

  end
end
