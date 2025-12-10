extends CharacterBody2D
@onready var nav :NavigationAgent2D = $NavigationAgent2D
var direction : int 
@export var speed = 400
@export var gravity : int
@onready var player : CharacterBody2D  = get_tree().get_nodes_in_group("player")[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
    move_player()
    if not is_on_floor():
        velocity.y += gravity * delta

    flip()
    
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

func _on_timer_timeout() -> void:
    nav.target_position = player.global_position
    
func flip():
    
    direction = int(player.global_position.x - self.global_position.x)

    for sprite in %Sprites.get_children():
        sprite.flip_h = direction<0
        
        
    
func move_player():
    if is_on_floor():
        if get_slide_collision_count() > 0:
            var collider = get_slide_collision(0).get_collider()
            if collider != null:
                var y_position = self.global_position.y - collider.global_position.y
## checks if its colliding with the player and if its above it  with an offset of 17
                if collider is  CharacterBody2D and y_position <= -18:
                    #print(y_position)
                    if collider.global_position.x - self.global_position.x > 0:
                        collider.global_position.x += 30
                        self.global_position.x -= 10

                    elif collider.global_position.x - self.global_position.x < 0:
                        collider.global_position.x -= 30
                        self.global_position.x += 10
                    
                 

    
    
    
    
    
    
    
