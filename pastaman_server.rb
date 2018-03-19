require 'optparse'
require 'socket'

# Simple server to which a facebook bot can respond to.
# Requests made to this server are also printed to the command-line.

DEFAULT_HOST = '127.0.0.1'
DEFAULT_PORT = 3000

options = {}
options[:host] = DEFAULT_HOST
options[:port] = DEFAULT_PORT

OptionParser.new do |opts|
  opts.banner = "Usage: pastaman_server.rb [options]"

  opts.on("--host HOST", String,
          "Specify the server's host. ex.: " + DEFAULT_HOST) do |v|
    options[:host] = v
  end
  opts.on("-p", "--port PORT", Integer,
          "Specify the server's port. ex.: " + DEFAULT_PORT.to_s) do |v|
    options[:port] = v
  end

  opts.on("-h", "--help", "Print this help") do
    puts opts
    exit
  end
end.parse!

server = TCPServer.new(options[:host], options[:port])
requests_nb = 0

puts 'Listening on ' + options[:host] + ':' + options[:port].to_s

loop do
  socket = server.accept

  requests_nb += 1
  puts 'Request number ' + requests_nb.to_s

  while (request = socket.gets)
    puts request.chomp
    break if request =~ /^\s*$/
  end

  response = "{\"response\":\"ok\"}"

  socket.print "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: application/json\r\n" +
                   "Content-Length: #{response.bytesize}\r\n" +
                   "Connexion: close\r\n"

  socket.print "\r\n"
  socket.print response
  socket.close
end