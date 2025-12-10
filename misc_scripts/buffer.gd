extends State
class_name buffer
@onready var JC = %JumpController
## I use JC to call variables from JumpController AND before calling substates

func Enter():

    print("buffer entered")
    %H_jump.visible = true
    set_nodes_visible([%walk, %idle, %dash], false)

func Update(delta: float) -> void:
    
    if player.is_on_floor():
       player.velocity.x = 0
## If Jump Released IN THE AIR, BUFfER

    if (Input.is_action_just_released("jump")):
        %jump_buffer.start()
        JC.jump_buffered = true
        
        
## Transition to SJump if buffered
    if player.is_on_floor() and JC.jump_buffered:
      print("should enter Sjump")
      %jump_buffer.stop()
      JC.jump_buffered = false
      JC.set_substate("SJump")
      return
    
        
    
## If not buffered check if jump is held    
    elif player.is_on_floor() and Input.is_action_pressed("jump"):

## Important, only run The timer when it's stopped to prevent it from RESTARTING CONSTANTLY 
        if %JumpTimer.is_stopped():
          %JumpTimer.start()

    if player.is_on_floor() and Input.is_action_just_released("jump"):
        
        %JumpTimer.stop()
                  
        if JC.is_held:
            JC.is_held = false
            JC.set_substate("LJump")        
        else:
            JC.set_substate("SJump")
            
##Checks if jump has been pressed midair, to trigger the buffer, if it's not pressed again while on the floor it will transition to Idle
    elif player.is_on_floor() and not JC.jump_buffered and not Input.is_action_pressed("jump"):
        state_transition.emit(self,"Idle")
                                 
















    
    
    
