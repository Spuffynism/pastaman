require 'net/http'
require 'uri'

class Requester
  def self.make_request(request_config)
    uri = request_config["uri"]

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
    request.body = request_config["body"].to_json

    http.request(request)
  end

  def self.print_response(response)
    puts response.code
    puts response.each_header {|key, value| puts "\t#{key}:#{value}"}
  end
end