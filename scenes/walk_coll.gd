extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    call_deferred("to_work") # call deferred and call back node process physics are necessary for it too when work
    %coll_anim.play("Enable_Disable_Animation")  # Replace with your actual animation name 
func to_work():  
    for move in %walk_coll.get_children():
        var global_pos = move.global_position 
        
        %walk_coll.remove_child(move)
        %ch_body.add_child(move)
        move.owner = %ch_body
        move.scale = Vector2(5, 5)
        move.global_position = global_pos
        
        
    
    
    
    
    
    
    
    
    
    
    
