require 'json'

class Util
  def self.parse_json_file(file_name)
    if file_name.nil?
      raise Exception, ("file name cannot be nil")
    end

    unless File.file?(file_name)
      raise Exception, (file_name + " not found in directory")
    end

    config_file_content = File.read(file_name)

    JSON.parse(config_file_content, symbolize_names: true)
  end
end