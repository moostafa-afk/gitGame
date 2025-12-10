extends State
class_name MJump
@export var mid_jump:= 0
var block : bool = false
var time_held :float


func Enter():
    print("MJump entered")
    player.velocity.y = -mid_jump
    #%pause_animation.start()
    %AnimationPlayer.play("M_jump")
    %MoveHeld.stop()
    invisible()
    %M_jump.visible = true

###  Decides which frame the animation is stopped
#func _on_pause_animation_timeout() -> void:
    #%AnimationPlayer.pause()
    #%unpause_LJump.start()
#
### Decides for how long it is stopped 
#func _on_unpause_m_jump_timeout() -> void:
    #%AnimationPlayer.play("M_jump")
    #%AnimationPlayer.seek(0.2, true)
