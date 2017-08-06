require 'json'
require 'ostruct'

class RequestParser

  def initialize(file_name)
    @file_name = file_name
  end

  attr_accessor :file_name

  def parse_and_get_request (options)
    json_requests = parse_json_config_file
    requests = get_requests_from_config json_requests

    request = requests[options.request]

    unless request
      abort("request not found " + options.request)
    end

    # code smell - feature envy
    if options.uri
      pp options.uri
      request["uri"] = URI::parse("http://" + options.uri.to_s)
    else
      request["uri"] = build_uri options.hostname, options.port, options.path
    end

    request
  end

  private def build_uri (host, port, path)
    unless host
      abort("host must be specified")
    end

    unless path
      abort("path must be specified")
    end

    URI::HTTP.new(['http', nil, host, port, nil, path])
  end

  private def parse_json_config_file
    unless File.file?(file_name)
      abort(file_name + " not found in directory")
    end

    config_file_content = File.read(file_name)

    JSON.parse(config_file_content)
  end

  private def get_requests_from_config(config)
    requests = config["requests"]

    unless requests
      abort("no requests found in " + @file_name)
    end

    requests
  end
end