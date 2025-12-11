extends CharacterBody2D
#class_name drone
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var nav :NavigationAgent2D = $NavigationAgent2D
@export var speed = 400
var direction : int
var recoil := 0
func _on_recoil_from_blast():
    recoil = 200


func _physics_process(_delta: float) -> void:

## Connection to the drone blast happens here
######################################################################################
    var drone_blast := get_tree().get_first_node_in_group("drone_blast")
    if drone_blast and not drone_blast.is_connected("recoil_from_blast",_on_recoil_from_blast):
        drone_blast.connect("recoil_from_blast",_on_recoil_from_blast)
## This is the gravity for the recoil and over time sets it to 0
    if recoil != 0:
        recoil -= 10
#######################################################################################

    flip()
    var current_pos = global_position
    var next_pos = nav.get_next_path_position()
    var new_velocity = current_pos.direction_to(next_pos) * speed  

  ##Here we make it go to another state
    if nav.is_navigation_finished() :
        if recoil != 0:
            velocity.y -= recoil
            move_and_slide()
        return
        
    if nav.avoidance_enabled:
        nav.set_velocity(new_velocity)
    
    else:
        _on_navigation_agent_2d_velocity_computed(new_velocity)
        
    move_and_slide()
 
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
    velocity = safe_velocity
func _on_timer_timeout() -> void:
       nav.target_position = player.global_position 
        
func flip():
        direction = int(player.global_position.x - self.global_position.x)
        for sprite in %Sprites.get_children():
            sprite.flip_h = direction < 0
