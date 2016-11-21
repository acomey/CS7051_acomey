#!/usr/local/bin/ruby

require 'socket'
require 'thread/pool'

server = TCPServer.new('localhost',8000)

pool = Thread.pool(2)

loop do
	pool.process do

		Thread.start(server.accept) do |socket|

			request = socket.gets

			STDERR.puts request

			response = "Hello World!\n"


			socket.print "HTTP/1.1 200 OK\r\n" +
					"Content-Type: text/plain\r\n" +
					"Content-Length: #{response.bytesize}\r\n"+
					"Connection: close\r\n"

			socket.print "\r\n"

			socket.print response

			#socket.close

		end
	end
end
