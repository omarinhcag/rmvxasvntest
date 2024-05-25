# encoding: utf-8
class Game_Event < Game_Character
  alias oz_relocate_initialize initialize
  def initialize(map_id, event)
    oz_relocate_initialize(map_id, event)
    relocate
  end
  
  def relocate
    key = [@map_id, @id, "_oldPos"]
    _oldPos = $game_self_switches[key]
    if _oldPos
      moveto(_oldPos[0], _oldPos[1])
    end
  end
  def store_location
    _oldPos = [@x,@y]
    key = [@map_id, @id, "_oldPos"]
    $game_self_switches[key] = _oldPos
  end
end