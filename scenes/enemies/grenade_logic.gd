extends Area2D

## velocity isnt built in here so i have to add it
var velocity: Vector2
@export var speed : int = 600
var direction: Vector2
var touch_platform : bool = false
@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

func _ready() -> void:
## offset sprite by desired amount using a function
    offset()
    

func _physics_process(delta: float) -> void:
    
## Here I define velcoity since its not built in with area 2d
    velocity = speed * direction
    
## Touching platform
    if touch_platform == true:
        rotation = 0

## Not touching platform
    if touch_platform == false:
##Update position instead of velocity since its not built in 
      self.global_position += velocity * delta
    
        
func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("platforms"):
       #print("expand")
       touch_platform = true
    
    
    
func offset():
    
    ## normalized to prevent speed variaiton based on distance
    direction = (player.global_position - self.global_position).normalized()
    
## Slight offset for the x coordinate
    if direction.x > 0:
        self.global_position.x += 7
    else:
        self.global_position.x -= 7

## Slight offset for the y coordinate
    self.global_position.y += 3

## Set rotation 
    rotation = direction.angle()
    
