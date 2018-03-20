require 'json'
require 'ostruct'
require 'uri' # not sure if this is needed

class RequestParser

  def initialize(file_name)
    @file_name = file_name
  end

  attr_accessor :file_name

  def parse_and_get_request (options)
    json_requests = parse_config_file @file_name
    requests = get_requests_from_config json_requests

    unless options.request
      raise Exception, "request not specified"
    end

    # get the specific request
    request = requests[options.request]

    unless request
      raise Exception, "request not found : " + options.request
    end

    # code smell - feature envy
    # If an uri has been specified, use it. Otherwise, build it.
    if options.uri
      request["uri"] = options.uri
    else
      request["uri"] = build_uri options.hostname, options.port, options.path
    end

    request
  end

  private def parse_config_file file_name
    unless File.file?(file_name)
      raise Exception, (file_name + " not found in directory")
    end

    config_file_content = File.read(file_name)

    JSON.parse(config_file_content)
  end

  private def get_requests_from_config(config)
    requests = config["requests"]

    unless requests
      raise Exception, ("no requests found in " + @file_name)
    end

    requests
  end

  private def build_uri (host, port, path)
    unless host
      raise Exception, ("host must be specified")
    end

    URI::HTTP.build(host: host, port: port, path: path)
  end
end