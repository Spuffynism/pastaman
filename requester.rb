require 'net/http'
require 'uri'

# Makes requests
class Requester
  # Makes and print a request
  # Params:
  # +request_config+:: the request configuration containing a uri and a body
  def self.do_and_print(request_config)
    response = make_request request_config
    print_response response
  end

  private
  # Makes a request and returns the response
  # Params:
  # +request_config+:: the request configuration containing a uri and a body
  def self.make_request(request_config)
    uri = request_config[:uri]

    puts uri.request_uri
    http = Net::HTTP.new(uri.host, uri.port)
    headers = {'Content-Type' => 'application/json'}
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = request_config[:body].to_json

    http.request(request)
  end

  # Prints a request response
  # Params:
  # +response+:: the request's response
  def self.print_response(response)
    puts "Response:"
    puts response.code
    response.each_header do |header, value|
      puts "#{header}:#{value}"
    end
  end
end