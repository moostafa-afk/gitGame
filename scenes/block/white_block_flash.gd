extends Node

var has_entered_func = false
var collider_subsitute  
func _physics_process(delta: float) -> void:
# this if statement is used to turn off the flash if it hasnt collided with the shield
    (owner.material as ShaderMaterial).set_shader_parameter("LIGHTNING_active", false)
    var shield = get_tree().get_first_node_in_group("spider_shield")
    if shield:  
        if not shield.is_connected("white_block", on_white_block):
            shield.connect("white_block",  on_white_block)

## We use the emitted collider form the spider_shiled scene and delete it with queue free
func on_white_block(collider: TileMapLayer):    
    if has_entered_func == false:
      (collider.material as ShaderMaterial).set_shader_parameter("LIGHTNING_active", true)
      collider_subsitute = collider
      %flash_timer.start()
      has_entered_func = true
func _on_glow_timer_timeout() -> void:
## reset the flag
    has_entered_func = false
    if collider_subsitute:
        collider_subsitute.call_deferred("queue_free")
