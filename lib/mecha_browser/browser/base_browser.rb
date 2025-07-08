module MechaBrowser
  module Browser
    class BaseBrowser
      def initialize
        @user_agent = nil
        @verbose = false
        @logger = nil
      end
      attr_accessor :user_agent
      attr_accessor :verbose
      attr_accessor :logger

      def browse(url)
        raise NotImplementedError, "Subclasses must implement the run method"
      end

      private
      def log(msg, put_log = @verbose)
        return unless put_log
        if @logger
          @logger.info(msg)
        else
          puts msg
        end
      end
    end
  end
end