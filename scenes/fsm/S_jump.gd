extends State
class_name SJump
@export var small_jump:= 0
var block : bool = false
var time_held :float
var s_released := false
func Enter():
    %jump_buffer.start()
    player.velocity.y = -small_jump
    %MoveHeld.stop()
    print("SJump entered")
    invisible()
    %small_jump.visible = true
    %AnimationPlayer.play("small_jump")
    if %AnimationPlayer.is_playing():
      %AnimationPlayer.seek(0)
        
func Update(_delta):

    if !player.is_on_floor(): 
        state_transition.emit(self,"Fall")
    if Input.is_action_just_pressed("block"):
        state_transition.emit(self,"Block")

    if not player.is_on_floor() and Input.is_action_just_pressed("jump"):
        %jump_buffer.start()
        
    #if player.is_on_floor():
        #if %jump_buffer.time_left > 0:
            #player.velocity.y 

    #if player.velocity.y > 0:
        #state_transition.emit(self,"Fall")
    #%Fall.Midair_speed()
    
    
func buffer_coyote():
## Enter Coyote Jump From Fall
    if %Fall.coyote_jump:
        %Fall.coyote_jump = false
        %coyote_timer.stop()
