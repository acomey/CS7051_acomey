require 'socket'
require 'json'
require 'thread'

port = ARGV[0]

server = TCPServer.open(port)

rm_number = Hash.new()        #maps room name to room id
clients = Hash.new()
rooms = Array.new()

room_id = 0           #server id for chat_room
client_id = 0

loop do

  Thread.start(server.accept) do |socket|

    msg = socket.gets                   #reads request message from client

    lines = msg.split("\n")
    room_name = lines[0].split(": ")[1]
    client_name = lines[3].split(": ")[1]

    clients[client_name] = client_id                #adds the new client to list of clients
    client_id += 1

    if rm_number[room_name].nil? == true          #checks if there is already a chatroom with this name
      rm_number[room_name] = room_id
      rooms[room_id] = Array.new()                #if none exist, create a new one
      room_id += 1
    end

    id = rm_number[room_name]
    rooms[id].push(client_name)                   #adds the new client to requested chatroom

    join_response = "JOINED_CHATROOM: #{room_name} \nSERVER_IP: 134.226.56.4 \nPORT: #{port} \nROOM_REF: #{id} \nJOIN_ID: #{client_id -1}"
    socket.print()

  end
end
