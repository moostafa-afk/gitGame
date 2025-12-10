extends State
class_name HJump
@export var H_Speed := 1200
@export var H_Jump:= 0

# Called when the node enters the scene tree for the first time.
func Enter():
    print("HJump entered")
    player.velocity.y = -H_Jump
    player.velocity.x = H_Speed * player.facing_direction
    %AnimationPlayer.play("H_jump")
    invisible()
    %H_jump.visible = true
    
##Use move and slide in ENTER cuz of velocity.x
    
func Update(_delta: float) -> void:
    
    %Move.move_is_held = false ## Reseting it only works here ???!!!
    if player.velocity.y > 0:
      state_transition.emit(self,"Fall")



    
    
    
    
    
    
    
    
    
    
