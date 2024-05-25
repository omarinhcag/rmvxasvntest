# encoding: utf-8
class Scene_Map < Scene_Base
  TRANSITION_DURATION = 60
  TRANSITION_TOTAL_ROTATION = 360
  TRANSITION_TOTAL_ZOOM = 4.0
  TRANSITION_COLOR = Color.new(255,255,255,255)
  TRANSITION_FOLLOW_PLAYER = true
  TRANSITION_MODE = 1
  
  def pre_battle_scene
    Graphics.update
    Graphics.freeze
    #@spriteset.dispose_characters
    BattleManager.save_bgm_and_bgs
    BattleManager.play_battle_bgm
    Sound.play_battle_start
  end
  
  def perform_battle_transition
    #SceneManager.snapshot_for_background
    Graphics.update
    blocker = Sprite.new
    blocker.z = 6666666
    blocker.bitmap = Bitmap.new(Graphics.width,Graphics.height)
    blocker.bitmap.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(0,0,0,255))
    
    target_x = TRANSITION_FOLLOW_PLAYER ? $game_player.screen_x : Graphics.width / 2
    target_y = TRANSITION_FOLLOW_PLAYER ? $game_player.screen_y : Graphics.height / 2
    
    funnysprite = Sprite.new
    funnysprite.ox = target_x
    funnysprite.oy = target_y
    funnysprite.x = target_x
    funnysprite.y = target_y
    funnysprite.z = blocker.z+1
    funnysprite.bitmap = SceneManager.background_bitmap
    c = TRANSITION_COLOR
    _addzoom = (TRANSITION_TOTAL_ZOOM-1)
    if TRANSITION_MODE==2
      step = 1.0 / TRANSITION_DURATION
      funnysprite.angle = (TRANSITION_TOTAL_ROTATION * step)
      funnysprite.zoom_x = funnysprite.zoom_y = 1 + (_addzoom * step)
      print(funnysprite.zoom_x)
      funnysprite.color = Color.new(c.red,c.green,c.blue,(step*c.alpha).round)
      funnysprite.opacity = 255
    else
      funnysprite.color = Color.new(c.red,c.green,c.blue,0)
    end
    
    Graphics.transition(0)
    
    TRANSITION_DURATION.times {|i|
      if TRANSITION_MODE==2
        blocker.bitmap = Graphics.snap_to_bitmap
        funnysprite.bitmap = blocker.bitmap
        funnysprite.angle = (i * TRANSITION_TOTAL_ROTATION) / TRANSITION_DURATION
        funnysprite.zoom_x = funnysprite.zoom_y = 1 + (i * _addzoom) / TRANSITION_DURATION
        funnysprite.opacity = 60
      else
        funnysprite.angle = (i * TRANSITION_TOTAL_ROTATION) / TRANSITION_DURATION
        funnysprite.zoom_x = funnysprite.zoom_y = 1 + (i * _addzoom) / TRANSITION_DURATION
        j = (i * c.alpha) / TRANSITION_DURATION
        funnysprite.color.alpha = j
      end
      # Update
      blocker.update
      funnysprite.update
      Graphics.update
      Input.update
    }
    
    funnysprite.dispose
    blocker.dispose
    
    Graphics.freeze
  end
  
end