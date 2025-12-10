extends Node2D
var velocity: Vector2
@export var speed : int = 600
var direction: Vector2
var direction_x : int 
@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
signal point_of_collision(shape_rotation:float,point : Vector2)

func _ready() -> void:
    %Timer.start()
    %AnimationPlayer.play("laser_shoot")
    offset()

func _physics_process(delta: float) -> void:
    #print(owner.name)
## Here I define velcoity since its not built in with area 2d
    velocity = speed * direction 

##Update position instead of velocity since its not built in 
    self.global_position += velocity * delta
    
### Checks to see if the area hasnt been deleted, if it is deleted, the sprite deletes itself too
    if %laser_area.is_colliding():
        point_of_collision.emit(%laser_area.global_rotation, %laser_area.point)
        self.queue_free()
        
func offset():

## normalized to prevent speed variaiton based on distance
    direction = (player.global_position - self.global_position).normalized()
## This offset will only apply when ready so need to worry about (+=) sign
   
## Slight offset for the x coordinate
    if direction.x > 0:
        self.global_position.x += 7
    else:
        self.global_position.x -= 7

## Slight offset for the y coordinate
    self.global_position.y += 3
    
## Set rotation 
    rotation = direction.angle()
    


func _on_timer_timeout() -> void:
    if %laser_area.is_colliding() == false:
        queue_free()
        
