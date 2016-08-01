class Pavel::Directory

  class << self
    def source_exists?
      File.directory?(source)
    end

    def temp_exists?
      File.directory?(temp)
    end

    def target_exists?
      File.directory?(target)
    end

    private

      def temp
        Pavel.temp[:path]
      end

      def source
        Pavel.source[:path]
      end

      def target
        Pavel.target[:path]
      end

  end

end
