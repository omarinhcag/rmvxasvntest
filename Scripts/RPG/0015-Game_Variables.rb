# encoding: utf-8
#==============================================================================
# ** Game_Variables
#------------------------------------------------------------------------------
#  This class handles variables. It's a wrapper for the built-in class "Array."
# The instance of this class is referenced by $game_variables.
#==============================================================================

class Game_Variables
  @@registered_events = {}
  @@changed = []
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    @data = []
  end
  #--------------------------------------------------------------------------
  # * Get Variable
  #--------------------------------------------------------------------------
  def [](variable_id)
    @data[variable_id] || 0
  end
  #--------------------------------------------------------------------------
  # * Set Variable
  #--------------------------------------------------------------------------
  def []=(variable_id, value)
    @data[variable_id] = value
    @@changed.push(variable_id)
    on_change
  end
  #--------------------------------------------------------------------------
  # * Processing When Setting Variables
  #--------------------------------------------------------------------------
  def on_change
    $game_map.need_refresh = true
  end
end
