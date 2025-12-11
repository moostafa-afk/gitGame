extends State
class_name LJump
@export var large_jump:= 0

# Called when the node enters the scene tree for the first time.
func Enter():
    print("LJump entered")
    player.velocity.y = -large_jump
    %AnimationPlayer.play("L_jump")
    %pause_animation.start()
    invisible()
    %L_jump.visible = true
    
##  Decides which frame the animation is stopped
func _on_pause_animation_timeout() -> void:
    %AnimationPlayer.pause()
    %unpause_LJump.start()

## Decides for how long it is stopped 
func _on_unpause_l_jump_timeout() -> void:
    %AnimationPlayer.play("L_jump")
    %AnimationPlayer.seek(0.2, true)
