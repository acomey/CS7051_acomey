require 'socket'
require 'json'
require 'thread'

server = TCPServer.open(8000)

rm_number = Hash.new()
clients = Hash.new()
rooms = Array.new()

room_id = 0           #server id for chat_room
client_id = 0

loop do

  Thread.start(server.accept) do |socket|

    msg = JSON.parse(socket.gets)                   #reads request message from client
    room_name = msg["Join_Chatroom"]
    client_name = msg["Client_Name"]

    clients[client_name] = client_id                #adds the new client to list of clients
    client_id += 1

    if rm_number[room_name].nil? == true          #checks if there is already a chatroom with this name
      print "\n"
      rm_number[room_name] = room_id
      rooms[room_id] = Array.new()                #if none exist, create a new one
      room_id += 1
    end

    id = rm_number[room_name]
    rooms[id].push(client_name)                   #adds the new client to requested chatroom

    #print rooms

    join_response =  { :Joined_Chatroom => room_name, :Room_ref => id, :Join_id => client_id }.to_json
    socket.print(join_response)


  end
end
