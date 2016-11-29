require 'socket'

port = ARGV[0]
server = TCPServer.new(port)

loop do

  Thread.start( server.accept) do |socket|

    loop do

      message = socket.gets

      if message = "KILL_SERVICE\n"
        socket.close

      elsif message = "HELO text\n"
        socket.print("HELO text\nIP:127.0.0.1\nPort:#{port}\nStudentID:12308907")

      end

    end
  end
end
