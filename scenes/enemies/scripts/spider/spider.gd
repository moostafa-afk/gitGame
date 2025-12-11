extends CharacterBody2D                     
@onready var nav :NavigationAgent2D = $NavigationAgent2D
var direction : int 
@export var speed = 400
@export var gravity : int
@onready var player : CharacterBody2D  = get_tree().get_nodes_in_group("player")[0]
var timer: float = 0.
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
    
    #flip()

## This timer is for how often the navigation resets its path to find the player
    timer += delta
    if not is_on_floor():
        velocity.y += gravity * delta
    
    var current_pos = global_position
    var next_pos = nav.get_next_path_position()
    var new_velocity = current_pos.direction_to(next_pos) * speed    
    var newer_velocity = Vector2(new_velocity.x, 0)
        
##Here we make it go to another state
    if nav.is_navigation_finished():
        return
        
        
## Here I set it to the newer velocity which only has an (x_value)
    if nav.avoidance_enabled:
        nav.set_velocity(newer_velocity)
        
    else:
        _on_navigation_agent_2d_velocity_computed(newer_velocity)

    move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
    
## Here we make sure we only add .x,  because if we dont it will override the y value of Limbo AI which prevents jumping
    velocity.x = safe_velocity.x

    #print(velocity.y)
    if timer >= .1:
        nav.target_position = player.global_position
        timer = 0.
        
func flip():
    direction = int(player.global_position.x - self.global_position.x)
    for sprite in %Sprites.get_children():
        sprite.flip_h = direction<0
        
        
        
    
