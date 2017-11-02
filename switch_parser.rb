require 'optparse'
require 'optparse/uri'
require 'ostruct'

DEFAULT_CONFIG_FILE = "config.json"
DEFAULT_REQUESTS_FILE = "requests.json"

# parses command-line switches
class SwitchParser
  def self.parse(args)
    options = OpenStruct.new
    options.request = ""
    options.times = 1
    options.config_file = DEFAULT_CONFIG_FILE
    options.requests_file = DEFAULT_REQUESTS_FILE

    switch_parser = OptionParser.new do |opts|
      opts.banner = "Usage: pastaman [options]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-n", "--hostname [HOSTNAME]", String,
              "The webhook's hostname (eg. \"localhost\").") do |name|
        options.hostname = name
      end

      opts.on("-p", "--port [PORT]", OptionParser::DecimalInteger,
              "The hostname's port, (eg. 8080).") do |port|
        options.port = port
      end

      opts.on("-w", "--webhook-url [WEBHOOK]", String,
              "The webhook url (eg. /facebook/webhook).") do |url|
        options.webhook_url = url
      end

      opts.on("-u", "--uri [URI]", URI,
              "A complete [HOSTNAME]:[PORT][WEBHOOK] uri (or anything accepted by URI.parse)") do |uri|
        options.uri = uri
      end

      opts.on("-cf", "--config CONFIG_FILE",
              "The config file. Default is #{options.config_file}") do |file|
        check_file_existence(file)

        options.config_file = file
      end

      opts.on("-rf", "--requests REQUESTS_FILE",
              "The request file. Default is #{options.requests_file}") do |file|
        check_file_existence(file)

        options.requests_file = file
      end

      opts.on("-r", "--request REQUEST", "The request's name (eg. \"text_message\"") do |name|
        options.request << name;
      end

      opts.on("-t", "--times [TIMES]", OptionParser::DecimalInteger,
              "The number of times the request should be made. Default is #{options.times}.") do |times|
        options.times = times
      end

      opts.on("-h", "--help", "Show this help.") do
        puts opts
        exit
      end
    end

    switch_parser.parse!(args)
    options
  end

  private
    def check_file_existence(file)
      unless File.exists?(file) && File.file?(file)
        abort("file : " + file + " does not exist or is a directory")
      end
    end
end