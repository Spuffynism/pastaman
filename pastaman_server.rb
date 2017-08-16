require 'socket'

server = TCPServer.new('127.0.0.1', 3000)
requests_nb = 0
loop do
  socket = server.accept
  request = socket.gets

  requests_nb += 1
  STDERR.puts  "#{requests_nb} #{request}"

  response = "{\"response\":\"ok\"}"

  socket.print "HTTP/1.1 200 OK\r\n" +
      "Content-Type: application/json\r\n" +
      "Content-Length: #{response.bytesize}\r\n" +
      "Connexion: close\r\n"

  socket.print "\r\n"
  socket.print response
  socket.close
end