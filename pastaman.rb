require_relative 'request_parser'
require_relative 'requester'
require_relative 'switch_parser'
require 'pp'

# parse the command line arguments
options = SwitchParser.parse(ARGV)

# parse & get request
config_parser = RequestParser.new options.requests_file
request = config_parser.parse_and_get_request options

# do the request
response = Requester.make_request request

# print the response
Requester.print_response response