#!usr/local/bin/ruby

require 'socket'
require 'thread'

host = 'localhost'     # The web server
port = 8000                           # Default HTTP port
path = "/echo.php?message=test "                 # The file we want
#path2 = "/echo1.php?message= anti-test "
# This is the HTTP request we send to fetch a file

request = "GET #{path} HTTP/1.0\r\n\r\n"


socket = TCPSocket.open(host,port)  # Connect to server

loop do

  socket.print(request)	# Send request
  response = socket.read              # Read complete response
  headers,body = response.split("\r\n\r\n", 2)
  print body                          # And display it
end
