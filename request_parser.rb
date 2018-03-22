require_relative 'util'
require 'json'
require 'uri'

# Parses options to requests
class RequestParser

  def initialize(options)
    @options = options
  end

  attr_accessor :options

  # Parses and returns the request specified in @options, using @options.
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

    request[:uri] = build_uri
    request
  end

  # Builds a URI from @options.
  private def build_uri
    # If an uri has been specified, use it. Otherwise, build it.
    if !@options[:uri].nil?
      uri = @options[:uri]
    else
      uri = build_uri_from_parts(@options[:hostname], @options[:port],
                                 @options[:webhook_path])
    end

    uri
  end

  # Builds a URI from parts.
  # Params:
  # +host+:: the uri's host name
  # +port+:: the uri's port (may be nil)
  # +path+:: the uri's path (may be nil)
  private def build_uri_from_parts (host, port, path)
    unless host
      raise Exception, ("host must be specified")
    end

    URI::HTTP.build(host: host, port: port, path: path)
  end
end