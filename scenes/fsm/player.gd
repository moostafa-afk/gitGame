extends CharacterBody2D
class_name Player
var direction: int = 0
var facing_direction := 0
@export var gravity = 1000
var old_health : = 100.0
var is_on_block := false
signal player_on_block(is_on_block)
signal add_block


func _ready() -> void: 
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
    on_block()
    disable_tiles()
    #set_collision_mask_value(5,true)
    %Fall.Gravity(delta)
    move_and_slide()
    flip()
    ## A check to see if the player was hit and make the hurt animation play

## Resetting the old health here in the line above

    ## This returns a -1 or +1 for direction
    direction = int(Input.get_axis("left" ,"right"))
    
    if direction != 0:
        facing_direction = direction
     
    ##Used to prevent it from getting stuck to the ceiling
    if is_on_ceiling():
        velocity.y  = gravity * delta
        velocity.x = 0

func flip():
    
    for sprite in %Sprites.get_children():
        sprite.flip_h = facing_direction < 0
        
func disable_tiles():
    if Input.is_action_pressed("down")  :
        set_collision_mask_value(5, false)
    else:
        set_collision_mask_value(5, true)

func on_block():
    
        if is_on_floor() and %on_block.is_colliding():
            if %on_block.get_collider(0) != null:
                if %on_block.get_collider(0).is_in_group("blocks"):
                    is_on_block = true
                    if is_on_block == true:
                        #print("its true")
                        player_on_block.emit(is_on_block)
        else:
                is_on_block = false
                #print("its false")
                player_on_block.emit(is_on_block)
