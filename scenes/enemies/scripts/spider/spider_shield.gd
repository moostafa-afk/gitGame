extends Node2D
                      
                    
## What we do is emit the collider which in this case would be the tilemap layer (blocks)                      
signal white_block(collider:TileMapLayer)   

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    call_deferred("queue_free")
                                
func _physics_process(delta: float) -> void:
    if %ShapeCast2D.is_colliding():
        var blocks = get_tree().get_first_node_in_group("blocks")
        var collider = %ShapeCast2D.get_collider(0)
        
## This check is very important cuz the block may delete on its own.
        if collider:
            if collider.is_in_group("blocks"):
                    white_block.emit(collider)
