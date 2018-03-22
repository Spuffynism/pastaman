require 'json'

class Util
  def self.parse_json_file file_name
    if file_name.nil?
      raise Exception, ("file name cannot be nil")
    end

    unless File.file?(file_name)
      raise Exception, (file_name + " not found in directory")
    end

    config_file_content = File.read(file_name)

    JSON.parse(config_file_content, symbolize_names: true)
  end

  #TODO: move this somewhere else
  def self.override_options(current_options, new_options)
    {
        request: current_options[:request] || new_options[:request],
        hostname: current_options[:hostname] || new_options[:hostname],
        port: current_options[:port] || new_options[:port],
        webhook_path: current_options[:webhook_path] ||
            new_options[:webhook_path],
        uri: current_options[:uri] || new_options[:uri],
        requests_file: current_options[:requests_file] ||
            new_options[:requests_file],
        times: current_options[:times] || new_options[:times],
    }
  end
end