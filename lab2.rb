require 'socket'

port = ARGV[0]
server = TCPServer.new(port)

loop do

  Thread.start( server.accept) do |socket|

    loop do

      message = socket.gets

      if message = "KILL_SERVICE\n"
        socket.close

      elsif message = "HELO BASE_TEST\n"
        socket.print("HELO text\nIP:134.226.56.4\nPort:#{port}\nStudentID:12308907")
        puts "Hello message received! \n"
      end

    end
  end
end
