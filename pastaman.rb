require_relative 'request_parser'
require_relative 'requester'
require_relative 'switch_parser'
require 'pp'

# parse command line arguments
options = SwitchParser.parse(ARGV)

# parse & get request
config_parser = RequestParser.new options
request = config_parser.parse_and_get_request

# execute the request
(1..options[:times]).each do |i|
  response = Requester.make_request request

  # print the response
  Requester.print_response response
end