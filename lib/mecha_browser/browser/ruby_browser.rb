require "web_loader"

module MechaBrowser
  module Browser
    class RubyBrowser < BaseBrowser
      def initialize
      end

      def browse(url)
        log("RubyBrowser : #{url} #{@user_agent} #{@verbose}")

        loader = ::WebLoader::Command.new
        loader.user_agent = @user_agent
        loader.verbose = @verbose
        loader.logger = @logger
        loader.use_cache = false
        result = loader.load(url)
        result
      end

    end
  end
end