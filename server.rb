#! /usr/local/bin/ruby

require "socket"
require "colorize"

server = TCPServer.new(2345)
player1 = ""
player2 = ""

loop do
  socket = server.accept
  msg = socket.gets
  msg = msg.chomp
  puts msg.inspect
  if msg == "get player 1"
    socket.puts player1
  elsif msg == "get player 2"
    socket.puts player2
  elsif msg =~ /^player 1 = .+$/
    player1 = msg[11..-1]
    socket.puts "succes"
  elsif msg =~ /^player 2 = .+$/
    player2 = msg[11..-1]
    socket.puts "succes"
  else
    socket.puts "ERROR: unknown req"
    puts "ERROR: unknown req".red
  end
  socket.close
  puts "got req"
  puts player1
end