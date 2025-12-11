extends Area2D

## velocity isnt built in here so i have to add it
signal coll_right(extent_right: Vector2)
signal coll_left(extent_left: Vector2)
signal area_spread(spread: int)

var velocity: Vector2
@export var speed : int = 600
var direction: Vector2
var touch_platform : bool = false
@export var spread: float = .9
@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]


## Collsion related things here
@onready var coll_right_side = CollisionShape2D.new()
@onready var coll_left_side = CollisionShape2D.new()

func _ready() -> void:
    offset()
    %coll_shape.shape = RectangleShape2D.new()
    %coll_shape.shape.extents = Vector2(10,10)    
     
func _physics_process(delta: float) -> void:
    
    emit_signal("coll_left", %left.position)

## Here I define velcoity since its not built in with area 2d
    velocity = speed * direction
    
## Touching platform
    if touch_platform == true:
        rotation = 0
        emit_signal("coll_right", %right.position)
        
    ## Makes the position to the amonunt of shape extents
    # So its growing from both sides but this gives the illusion of only growing from one
        emit_signal("area_spread", spread)
        if %left.is_colliding() and %right.is_colliding():
    ## it spreads thin due to it spreading in both sides so i have to add *2
            %coll_shape.shape.extents.x += spread * 2
            %right.position.x = %coll_shape.shape.extents.x 
            %left.position.x = -%coll_shape.shape.extents.x 
    
    
        elif %right.is_colliding():
            add_coll_right()
            coll_right_side.shape.extents.x += spread  
            coll_right_side.position.x = coll_right_side.shape.extents.x + %coll_shape.shape.extents.x
            %right.position.x = coll_right_side.position.x + coll_right_side.shape.extents.x
            emit_signal("coll_right", %right.position)
            
        elif %left.is_colliding():
            add_coll_left()
            coll_left_side.shape.extents.x += spread  
            coll_left_side.position.x = -coll_left_side.shape.extents.x -%coll_shape.shape.extents.x 
            %left.position.x = coll_left_side.position.x - coll_left_side.shape.extents.x
            

## Not touching platform
    elif touch_platform == false:
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
    
#func load_grendae():
    #var load_area :PackedScene = preload("res://scenes/enemies/electric_drone.tscn")
    #var inst = load_area.instantiate()
    #add_child(inst)
    #

func add_coll_right():
    if not(coll_right_side.get_parent() ):
        coll_right_side.shape = RectangleShape2D.new()
        coll_right_side.shape.extents = Vector2(16,10)
        self.add_child(coll_right_side)
        
func add_coll_left():
    if not(coll_left_side.get_parent() ):
        coll_left_side.shape = RectangleShape2D.new()
        coll_left_side.shape.extents = Vector2(16,10)
        self.add_child(coll_left_side)
        
          



#func _on_timer_timeout() -> void:
#
        #%coll_shape.queue_free()
