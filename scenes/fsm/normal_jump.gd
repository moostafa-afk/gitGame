extends State
class_name SJumpp
@export var small_jump:= 0
var block : bool = false
var time_held :float

func Enter():
    buffer_coyote()
    player.velocity.y = -small_jump
    %MoveHeld.stop()
    print("SJump entered")
    invisible()
    %small_jump.visible = true
    %AnimationPlayer.play("small_jump")
func Update(_delta):
    if player.velocity.y < 0:
        if Input.is_action_just_released("jump"):
            player.velocity.y *= .65
    if Input.is_action_just_pressed("block"):
        state_transition.emit(self,"Block")
    if player.velocity.y > 0:
        state_transition.emit(self,"Fall")
    %Fall.Midair_speed()
    
    
func buffer_coyote():
## Enter Coyote Jump From Fall
    if %Fall.coyote_jump:
        %Fall.coyote_jump = false
        %coyote_timer.stop()
