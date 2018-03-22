require_relative '../request_parser'
require 'uri'
require 'test/unit'

class TestRequestParser < Test::Unit::TestCase
  RESOURCES_DIR = "test/resources/"
  TEST_REQUESTS = RESOURCES_DIR + "test_requests.json"

  def test_set_options
    options = {test: "test"}
    request_parser = RequestParser::new options

    assert_equal(options, request_parser.options)
  end

  def test_parse_and_get
    options = {
        hostname: "test.host.name",
        port: 81,
        webhook_path: "/test/webhook/path",
        requests_file: TEST_REQUESTS,
        request: "test_message" # this request exists
    }

    request_parser = RequestParser::new options

    request = request_parser.parse_and_get_request

    assert_not_nil request[:uri]
    assert_not_nil request[:route]
    assert_not_nil request[:body]
  end

  def test_get_requests_no_request
    options = {
        requests_file: TEST_REQUESTS
    }
    assert_parse_and_get_request(RequestParser::new(options),
                                 /request not specified/)
  end

  def test_get_requests_not_found
    invalid_request_name = "invalid request name"
    options = {
        requests_file: TEST_REQUESTS,
        request: invalid_request_name
    }
    assert_parse_and_get_request(RequestParser::new(options),
                                 /not found/)
  end

  def test_uri_used
    uri = URI::HTTP.build(host: "test.uri", path: "/test/route")

    options = {
        uri: uri,
        requests_file: TEST_REQUESTS,
        request: "test_message" # this request exists
    }
    request_parser = RequestParser::new options

    request = request_parser.parse_and_get_request
    assert_equal(uri.to_s, request[:uri].to_s)
  end

  def test_uri_no_hostname
    options = {
        requests_file: TEST_REQUESTS,
        request: "test_message" # this request exists
    }
    assert_parse_and_get_request(RequestParser::new(options),
                                 "host must be specified")

  end

  def test_uri_built
    options = {
        hostname: "test.host.name",
        port: 81,
        webhook_path: "/test/webhook/path",
        requests_file: TEST_REQUESTS,
        request: "test_message" # this request exists
    }

    request_parser = RequestParser::new options

    request = request_parser.parse_and_get_request

    expected_uri = "http://" + options[:hostname] + ":" + options[:port].to_s +
        options[:webhook_path]
    assert_equal(expected_uri, request[:uri].to_s)
  end

  private def assert_parse_and_get_request(request_parser, error_message)
    assert_raise_message(error_message) do
      request_parser.parse_and_get_request
    end
  end
end