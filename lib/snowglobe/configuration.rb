module Snowglobe
  class Configuration
    attr_accessor :root_directory
    attr_accessor :temporary_directory
    attr_writer :project_name

    def initialize
      self.temporary_directory = Pathname.new("/tmp/snowglobe")
    end

    def project_name
      if @project_name
        @project_name
      else
        raise NotConfiguredError.new(<<~EXAMPLE)
          Snowglobe.configure do |config|
            config.project_name = "your_project_name"
          end
        EXAMPLE
      end
    end

    def update!
      yield self
    end

    class NotConfiguredError < StandardError
      def initialize(example)
        super(<<~MESSAGE)
          You need to configure Snowglobe before you can use it! For example:

          #{example}
        MESSAGE
      end
    end
  end
end
