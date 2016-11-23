require 'socket'
require 'json'

socket = TCPSocket.open("localhost",8000)

puts "Enter Username: \n"
name = gets.chomp
puts "What Room would you like to join?\n"
chat_room = gets.chomp

join_request = { :Join_Chatroom => chat_room, :Client_Name => name }.to_json
socket.print(join_request)


reply = JSON.parse(socket.gets)
puts reply

socket.close
