require_relative 'util'
require 'json'
require 'uri'

class RequestParser

  def initialize(options)
    @options = options
  end

  attr_accessor :options

  def parse_and_get_request
    requests = (Util.parse_json_file @options[:requests_file])[:requests]

    unless @options[:request]
      raise Exception, "request not specified (specify it with the -r flag)"
    end

    # get the specific request
    request = requests[@options[:request].intern]

    unless request
      raise Exception, "request '#{@options[:request]}' not found in file " +
          "#{@options[:requests_file]}"
    end

    # code smell - feature envy
    # If an uri has been specified, use it. Otherwise, build it.
    if !@options[:uri].nil?
      request[:uri] = @options[:uri]
    else
      request[:uri] = build_uri(@options[:hostname], @options[:port],
                                @options[:webhook_path])
    end

    request
  end

  private def build_uri (host, port, path)
    unless host
      raise Exception, ("host must be specified")
    end

    URI::HTTP.build(host: host, port: port, path: path)
  end
end