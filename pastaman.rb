require_relative 'request_parser'
require_relative 'requester'
require_relative 'switch_parser'
require 'pp'

# parse command line arguments
options = SwitchParser.parse(ARGV)

# parse & get request
parser = RequestParser.new options
request = parser.parse_and_get_request

# execute the request
(1..options[:times]).each {|i| Requester.do_and_print request}