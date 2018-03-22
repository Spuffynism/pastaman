require_relative '../util'
require 'test/unit'

class TestUtil < Test::Unit::TestCase
  def test_parse_json
    valid_file_name = "test/resources/test_util.json"

    file = Util.parse_json_file valid_file_name

    assert_equal("test_string", file[:key1])
    assert_equal(1, file[:key2])
  end

  def test_parse_json_file_nil
    assert_raise_message("file name cannot be nil") do
      Util.parse_json_file nil
    end
  end

  def test_parse_json_file_not_found
    invalid_file_name = "this_file_does_not_exist"
    expected = invalid_file_name + " not found in directory"

    assert_raise_message(expected) do
      Util.parse_json_file invalid_file_name
    end
  end
end