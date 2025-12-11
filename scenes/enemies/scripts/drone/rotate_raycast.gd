## This script here is for creating a line of sight for the drone 
extends RayCast2D
var speed := deg_to_rad(20.0) # radians per frame
var min_angle := deg_to_rad(-60)
var max_angle := deg_to_rad(60)
var direction := 1.0
signal player_detected

func _physics_process(delta: float) -> void:
    var player_direction = int(owner.player.global_position.x - owner.global_position.x)
    if player_direction < 0:
        scale.x  = -1

    else:
        scale.x  = 1

    rotation += speed * direction
        
    if rotation > max_angle:
        rotation = max_angle
        direction = -1.0
        
    elif rotation < min_angle:
        rotation = min_angle
        direction = 1.0
