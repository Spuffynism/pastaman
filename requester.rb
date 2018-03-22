require 'net/http'
require 'uri'

class Requester
  def self.make_request(request_config)
    uri = request_config[:uri]

    puts uri.request_uri
    http = Net::HTTP.new(uri.host, uri.port)
    headers = {'Content-Type' => 'application/json'}
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = request_config[:body].to_json

    http.request(request)
  end

  def self.print_response(response)
    puts "Response:"
    puts response.code
    response.each_header do |header, value|
      puts "#{header}:#{value}"
    end
  end
end