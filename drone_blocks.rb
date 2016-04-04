
def make_block(str, is_active)
  arr = str.split "|"
  id = arr[0]
  x = arr[1]
  y = arr[2]
  level = arr[3]
  ids = {"0" => DroneBlocks::FuelTank,
         "1" => DroneBlocks::Thruster,
         "2" => DroneBlocks::Battery,
         "3" => DroneBlocks::Gun,
         "4" => DroneBlocks::Propeller,
         "5" => DroneBlocks::Shield,
         "6" => DroneBlocks::Arm,
         "7" => DroneBlocks::Ammo,
         "8" => DroneBlocks::Controller,
         "9" => DroneBlocks::Collector,
         "a" => DroneBlocks::WaterTank}
  return ids[id].new x, y, level, is_active
end

image_names = {"0" => "fuel",
               "1" => "thruster",
               "2" => "battery",
               #"3" => "gun",
               #"4" => "propeller",
               #"5" => "shield",
               #"6" => "arm",
               #"7" => "ammo",
               #"8" => "controller",
               #"9" => "collector",
               #"a" => "water"}
images = {}

image_names.each do |id, name|
  new_hash = {}
  3.times do |n|
    new_hash[(n + 1).to_s] = Gosu::Image.new "images/#{name}#{n + 1}.png"
  end
  images[id.to_s] = new_hash
end

module DroneBlocks

class DroneBlock

  def initialize(x, y, level, is_active)
    @x = x.to_i
    @y = y.to_i
    @level = level.to_i
    @is_active = is_active
  end

  def draw(drone_x, drone_y, player_col)
    Gosu.draw_rect(drone_x + @x * 20, drone_y + @y * 20, 20, 20, player_col)
    @image.draw(drone_x + @x * 20, drone_y + @y * 20, 0)
  end

  def to_s
    "ERROR: block type is nil"
  end

end

class FuelTank < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["0"][level.to_s]
  end

  def to_s
    "0|#{@x}|#{@y}|#{@level}"
  end

end

class Thruster < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["1"][level.to_s]
  end
 
  def to_s
    "1|#{@x}|#{@y}|#{@level}"
  end

end

class Battery < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["2"][level.to_s]
  end
 
  def to_s
    "2|#{@x}|#{@y}|#{@level}"
  end
  
end

class Gun < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["3"][level.to_s]
  end
 
  def to_s
    "3|#{@x}|#{@y}|#{@level}"
  end
  
end

class Propeller < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["4"][level.to_s]
  end
 
  def to_s
    "4|#{@x}|#{@y}|#{@level}"
  end
  
end

class Shield < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["5"][level.to_s]
  end
 
  def to_s
    "5|#{@x}|#{@y}|#{@level}"
  end
  
end

class Arm < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["6"][level.to_s]
  end
 
  def to_s
    "6|#{@x}|#{@y}|#{@level}"
  end
  
end

class Ammo < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["7"][level.to_s]
  end
 
  def to_s
    "7|#{@x}|#{@y}|#{@level}"
  end
  
end

class Controller < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["8"][level.to_s]
  end
 
  def to_s
    "8|#{@x}|#{@y}|#{@level}"
  end
  
end

class Collector < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["9"][level.to_s]
  end
 
  def to_s
    "9|#{@x}|#{@y}|#{@level}"
  end
  
end

class WaterTank < DroneBlock

  def initialize(x, y, level, is_active)
    super
    @image = IMAGES["a"][level.to_s]
  end
 
  def to_s
    "a|#{@x}|#{@y}|#{@level}"
  end
  
end

end



DroneBlocks::IMAGES = images
