require_relative 'config_parser'
require_relative 'requester'

USAGE = <<ENDUSAGE
Usage:
  pastaman [-h] [-hn] [-w webhook_url] [-p port] [-c]
ENDUSAGE

HELP = <<ENDHELP
  -h,  --help         Show this help.
  -w,  --webhook-url  The webhook url (eg. "/facebook/webhook").
  -hn, --hostname     The webhook's hostname (eg. "localhost")
  -p,  --port         The hostname's port, (eg. 8080)
  -c,  --config       The config file's name
  -r,  --requests     The request file's name
ENDHELP

$default_config_file_name = "config.json"
$requests_file_name = "requests.json"

$url = ARGV[0]
$request_name = ARGV[1]

config_parser = ConfigParser.new $requests_file_name

json_requests = config_parser.parse_json_config_file
requests = config_parser.get_requests_from_config json_requests
response = Requester.make_request requests[$request_name], $url

Requester.print_response response