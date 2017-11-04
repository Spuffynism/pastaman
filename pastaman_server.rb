require 'socket'

# Simple server to which a facebook bot can respond to.
# The responses are simply printed to the command-line.

DEFAULT_IP = '127.0.0.1'
DEFAULT_PORT = 3000

server = TCPServer.new(DEFAULT_IP, DEFAULT_PORT)
requests_nb = 0

puts 'Listening on ' + DEFAULT_IP + ':' + DEFAULT_PORT.to_s

loop do
  socket = server.accept
  
  requests_nb += 1
  puts 'Request number ' + requests_nb.to_s
  
  while request = socket.gets
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