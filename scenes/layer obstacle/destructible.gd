extends Area2D

var platform_pos : Vector2i
var area_pos : Vector2i 

func _ready() -> void:
## The var tile_set is a global variable, and it refers to the destrucible layer in my case platforms
    platform_pos = Global.destruct_tile_set.local_to_map(global_position)
    area_pos = Global.area_tile_set.local_to_map(global_position)
    
    for platforms in platform_pos:
        if platforms:
            Global.area_tile_set.set_cell(area_pos)
    

    
## local map changes it position coordinates to block grid map coordinates for the tiles


func _on_area_entered(area: Area2D) -> void:
   if area.is_in_group("laser"):
     Global.destruct_tile_set.erase_cell(platform_pos)
     queue_free()
