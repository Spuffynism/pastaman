require 'optparse'
require 'socket'

# Simple server to which a facebook bot can respond to.
# Requests made to this server are printed to the command-line.

DEFAULT_HOST = "localhost"
DEFAULT_PORT = 3000

options = {
    host: DEFAULT_HOST,
    port: DEFAULT_PORT
}

OptionParser.new do |opts|
  opts.banner = "Usage: pastaman_server.rb [options]"

  opts.on("--host HOST", String,
          "Specify the server's host. Default is " + DEFAULT_HOST) do |host|
    options[:host] = host
  end
  opts.on("-p", "--port PORT", Integer,
          "Specify the server's port. Default is " + DEFAULT_PORT.to_s) do |port|
    options[:port] = port
  end

  opts.on("-h", "--help", "Print this help") do
    puts opts
    exit
  end
end.parse!

server = TCPServer.new(options[:host], options[:port])
requests_nb = 0

puts "Listening on " + options[:host] + ":" + options[:port].to_s

loop do
  socket = server.accept

  requests_nb += 1
  puts "Request number " + requests_nb.to_s

  # print the received request
  while (request = socket.gets)
    puts request.chomp
    break if request =~ /^\s*$/
  end

  response = "{\"message\":\"ok\"}"

  socket.print "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: application/json\r\n" +
                   "\r\n" +
                   response
  socket.close
end