class Pavel::Directory

  class << self
    def source_exists?
      File.directory?(source)
    end

    def target_exists?
      File.directory?(target)
    end

    private

      def source
        Pavel.source[:path]
      end

      def target
        Pavel.target[:path]
      end

  end

end
