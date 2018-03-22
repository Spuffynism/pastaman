require_relative 'util'
require 'optparse'
require 'optparse/uri'

DEFAULT_CONFIG_FILE = "config.json"
DEFAULT_OPTIONS = {
    hostname: "localhost",
    port: 80,
    webhook_path: "/facebook/webhook",
    requests_file: "requests/requests.json",
    times: 1,
}

# Parses command-line switches
class SwitchParser

  # Parses +args+ to a symbol-indexed hash
  # Params:
  # +args+:: arguments from the command line
  def self.parse(args)
    options = DEFAULT_OPTIONS
    config_file_options = Util.parse_json_file DEFAULT_CONFIG_FILE
    options = override_options(options, config_file_options)

    switch_parser = OptionParser.new do |opts|
      opts.banner = "Usage: pastaman [options].\n" +
          "Options can be specified in #{DEFAULT_CONFIG_FILE}.\n" +
          "If options are specified in #{DEFAULT_CONFIG_FILE}, they will " +
          "override the default ones.\nThen, if options are specified using " +
          "flags, those will override the ones in #{DEFAULT_CONFIG_FILE}."

      opts.on("-r", "--request [REQUEST]", "Name of the request to execute " +
          "(eg. text_message).") do |name|
        options[:request] = name;
      end

      opts.on("-n", "--hostname [HOSTNAME]", String,
              "Webhook's hostname. Default is " +
                  "#{DEFAULT_OPTIONS[:hostname]}.") do |name|
        options[:hostname] = name
      end

      opts.on("-p", "--port [PORT]", OptionParser::DecimalInteger,
              "Host's port. Default is #{DEFAULT_OPTIONS[:port]}.") do |port|
        options[:port] = port
      end

      opts.on("-w", "--webhook-path [WEBHOOK]", String,
              "Webhook path. Default is " +
                  "#{DEFAULT_OPTIONS[:webhook_path]}") do |path|
        options[:webhook_path] = path
      end

      opts.on("-u", "--uri [URI]", URI,
              "[HOSTNAME]:[PORT][WEBHOOK] uri (or anything accepted by " +
                  "URI.parse).") do |uri|
        options[:uri] = uri
      end

      opts.on("-f", "--requests [REQUESTS_FILE]",
              "Request file. Default is " +
                  "#{DEFAULT_OPTIONS[:requests_file]}.") do |file|
        check_file_existence(file)

        options[:requests_file] = file
      end

      opts.on("-t", "--times [TIMES]", OptionParser::DecimalInteger,
              "Number of times the request should be made. Default is " +
                  "#{DEFAULT_OPTIONS[:times]}.") do |times|
        options[:times] = times
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

  # Overrides +current_options+ options, if present in +new_options+
  # Params:
  # +current_options+:: the current options which will be overriden if an option
  # of the same symbol is present in +new_options+
  # +new_options+:: the new options which will override
  def self.override_options(current_options, new_options)
    current_options.each_key do |k|
      current_options[k] = new_options.fetch(k, current_options[k])
    end
  end

  # Raises an exception if the file does not exist
  def self.check_file_existence(file)
    unless File.exists?(file) && File.file?(file)
      raise Exception, ("file : " + file + " does not exist or is a directory")
    end
  end
end