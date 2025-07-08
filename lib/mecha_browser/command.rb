require "optparse"

module MechaBrowser
  USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"
  CONFIG_DIR = File.expand_path("~/.mechabrowser")

  class Config
    def self.load_config_file(config_file)
      yaml = nil
      if FileTest.file?(config_file)
        yaml = YAML.load_file(config_file)
      end
      load_from_yaml(yaml)
    end

    def self.load_from_yaml(yaml)
      config = Config.new
      config.user_agent = config_value(yaml, "browser", "user_agent", false)
      config.init_default
      config
    end

    def self.config_value(yaml, section, key, require)
      return nil unless yaml
      return nil unless yaml[section]
      value = yaml[section][key]
      if require && (value.nil? || value.empty?)
        raise RuntimeError, "#{section}:#{key}: is empty"
      end
      value
    end

    def initialize
      super
    end

    def init_default
      @user_agent ||= USER_AGENT
      @config ||= CONFIG_DIR
    end

    attr_accessor :user_agent
    attr_accessor :config_dir
  end

  class Command
    def self.run(argv)
      STDOUT.sync = true
      opts = {}
      opt = OptionParser.new(argv)
      opt.banner = "Usage: #{opt.program_name} [-h|--help] <options> <url>"
      opt.version = VERSION
      opt.separator('')
      opt.separator("Options:")
      opt.on_head('-h', '--help', 'Show this message') do |v|
        puts opt.help
        exit
      end
      opt.on('-v', '--verbose', 'Verbose message') {|v| opts[:v] = v}
      opt.on('-n', '--dry-run', 'Message only') {|v| opts[:n] = v}
      opt.on('-d', '--config-dir', 'Config directory'){|v| opts[:d] = v }
      types = ['ruby', 'selenium']
      opt.on('-t', '--type', types, types.join("|") + "(default ruby)") {|v| opts[:t] = v}
      opt.parse!(argv)
      opts[:t] ||= types[0]

      config_dir = opts[:d] || CONFIG_DIR
      config_dir = File.expand_path(config_dir)
      config_file = File.join(config_dir, "config.yml")

      config = Config.load_config_file(config_file)
      config.config_dir = config_dir
      command = Command.new(opts, config)
      command.run(argv)
      # filepaths = self.filter_files(argv)
      # if filepaths.empty?
      #   puts opt.help
      #   exit
      # end
      # filepaths.each do |filepath|
      #   command = Imagefilter.new(opts, config)
      #   command.run(filepath)
      # end
    end

    def initialize(opts, config)
      @opts = opts
      @config = config
      @verbose = opts[:v] || false
      @dry_run = opts[:n] || false
      @type = opts[:t] || 'ruby'
    end

    def run(argv)
      url = argv.shift
      browser = create_browser
      result = browser.browse(url)
      puts result.to_s
      result
    end

    private
    def create_browser
      case @type
      when 'ruby'
        browser = MechaBrowser::Browser::RubyBrowser.new
      # when 'selenium'
      #   require_relative 'browser/selenium_browser'
      #   browser = MechaBrowser::Browser::SeleniumBrowser.new
      else
        raise ArgumentError, "Unknown browser type: #{@type}"
      end
      browser.user_agent = @config.user_agent
      browser.verbose = @verbose
      browser.logger = @logger if @logger
      browser
    end
  end
end
