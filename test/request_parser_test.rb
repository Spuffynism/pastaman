require_relative "../request_parser"
require 'ostruct'
require 'uri'
require "test/unit"

class TestRequestParser < Test::Unit::TestCase
  RESOURCES_DIR = "test/resources/"
  VALID_CONFIG_FILE_NAME = RESOURCES_DIR + "test_config.json"

  def test_sets_file_name
    file_name = "test"
    request_parser = RequestParser::new file_name

    assert_equal(file_name, request_parser.options)
  end

  def test_parses_and_gets
    fail
  end

  def test_fail_config_not_found
    file_name = "test_file_that_does_not_exist.json"

    assert_parse_and_get_request(RequestParser::new(file_name),
                                 OpenStruct.new,
                                 file_name + " not found in directory")
  end

  def test_fail_config_not_json
    invalid_json_config_file = RESOURCES_DIR + "test_config_invalid_json.json"

    assert_parse_and_get_request(RequestParser::new(invalid_json_config_file),
                                 OpenStruct.new,
                                 /unexpected token at/)
  end

  def test_get_requests_from_config
    #todo test "no requests found in filename"
    fail
  end

  def test_fail_no_request_option
    assert_parse_and_get_request(RequestParser::new(VALID_CONFIG_FILE_NAME),
                                 OpenStruct.new,
                                 /request not specified/)
  end

  def test_fail_non_existent_request
    request_name = "request_that_does_not_exist"
    options = OpenStruct.new({:request => request_name})

    assert_parse_and_get_request(RequestParser::new(VALID_CONFIG_FILE_NAME),
                                 options, "request not found : " + request_name)
  end

  def test_uri_used
    uri = URI::HTTP.build(host: "test.uri", path: "/with/test/route")

    request_parser = RequestParser::new VALID_CONFIG_FILE_NAME
    options = OpenStruct.new ({
        :uri => uri,
        :request => "test_message" # this request exists
    })

    request = request_parser.parse_and_get_request options
    assert_equal(request["uri"].to_s, uri.to_s)
  end

  def test_uri_built
    fail
  end

  def test_build_uri_fail_host
    fail
  end

  private def assert_parse_and_get_request(request_parser, options,
                                           error_message)
    assert_raise_message(error_message) do
      request_parser.parse_and_get_request options
    end
  end
end