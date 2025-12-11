extends State
class_name Stp
@export var small_jump:= 0
var block : bool = false
var time_held :float


func Enter():
    player.velocity.y = -small_jump
    %MoveHeld.stop()
    print("SJump entered")
    invisible()
    %S_jump.visible = true
    %AnimationPlayer.play("small_jump")
