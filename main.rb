#! /usr/local/bin/ruby

require "gosu"
require "socket"
require "set"
require "./drone_blocks.rb"

module MicroDrones

include DroneBlocks

WIDTH = 800
HEIGHT = 600

private

class Board

  def initialize(player)
    @clouds = {}
    @zoom = 1
    @my_drones = MyDrones.new player.to_i
    if player.to_i == 1
      @enemy_drones = EnemyDrones.new(2)
    else
      @enemy_drones = EnemyDrones.new(1)
    end
  end

  def draw
    Gosu.scale(@zoom) do
      @my_drones.draw
      @enemy_drones.draw
    end
  end

  def update
    @my_drones.update
    @enemy_drones.update
  end

end

class MyDrones

  def initialize(player)
    @id = player
    if @id == 1
      @drones = [Drone.new("50 50 0|0|0|2")]
    else
      @drones = [Drone.new("100 50 1|0|0|3")]
    end
  end

  def draw
    @drones.each do |drone|
      drone.draw 0xff_00ff00
    end
  end

  def update
    str = ""
    @drones.each do |drone|
      if drone.to_s != "ERROR: block type is nil"
        str += drone.to_s
        str += "\n"
      else
        puts "ERROR: block type is nil"
      end
    end
    socket = TCPSocket.new "127.0.0.1", 2345
    socket.puts "player #{@id} = #{str}"
    puts socket.gets
  end

end

class EnemyDrones

  def initialize(other_player)
    @other_id = other_player
    puts @other_id
    @enemy_drones = Set.new
  end

  def draw
    @enemy_drones.each do |drone|
      drone.draw 0xff_ff0000
    end
  end

  def update
    socket = TCPSocket.new "127.0.0.1", 2345
    socket.puts "get player #{@other_id}"
    puts "@other_id = #{@other_id}"
    enemy_drones_str = socket.gets
    puts enemy_drones_str
    enemy_drones = enemy_drones_str.split "\n"
    new_enemy_drones = Set.new
    enemy_drones.each do |drone_str|
      new_enemy_drones.add DroneDummy.new drone_str
    end
    @enemy_drones = new_enemy_drones
  end

end

class Shop

  def initialize
    
  end

end

class Drone

  def initialize(str)
    arr = str.split(" ")
    @x = arr[0].to_i
    @y = arr[1].to_i
    @blocks = Set.new
    arr[2..-1].each do |block_str|
      @blocks.add make_block(block_str, true)
    end
  end

  def draw(player_col)
    @blocks.each do |block|
      block.draw(@x, @y, player_col)
    end
  end

  def update
    @blocks.each do |block|
      block.update
    end
  end

  def to_s
    str = "#{@x} #{@y}"
    @blocks.each do |block|
      if block.to_s == "ERROR: block type is nil"
        return "ERROR: block type is nil"
      end
      str += " #{block.to_s}"
    end
    str
  end

end

class DroneDummy

  def initialize(str)
    arr = str.split(" ")
    @x = arr[0].to_i
    @y = arr[1].to_i
    @blocks = Set.new
    arr[2..-1].each do |block_str|
      @blocks.add make_block(block_str, false)
    end
  end

  def draw(player_col)
    @blocks.each do |block|
      block.draw(@x, @y, player_col)
    end
  end

  def update
    
  end

  def to_s
    str = "#{@x} #{@y}"
    @blocks.each do |block|
      if block.to_s == "ERROR: block type is nil"
        return "ERROR: block type is nil"
      end
      str += " #{block.to_s}"
    end
    str
  end

end

public

class Screen < Gosu::Window

  def initialize(player)
    super WIDTH, HEIGHT
    self.caption = "Drones"
    @board = Board.new player
  end

  def draw
    @board.draw
  end

  def update
    @board.update
  end

  def needs_cursor?
    true
  end

end

end

print "Are you player 1 or 2? "
player = gets.chomp

MicroDrones::Screen.new(player).show