extends Area2D
var platform_pos : Vector2i 
var area_pos : Vector2i 
@onready var platform_tiles = get_tree().get_first_node_in_group("platforms")
@onready var area_tiles = get_tree().get_first_node_in_group("area")


func _ready() -> void:
## Local to map is used here since it returns a value of a singe Vector only, unlike get_used_cells which returns an entire array
    platform_pos = platform_tiles.local_to_map(global_position)
    area_pos = area_tiles.local_to_map(global_position)
    

    

func _on_area_entered(area: Area2D) -> void:
   if area.is_in_group("laser"):
## Erase cell needs only a vector as an argument not  a whole array
     platform_tiles.erase_cell(platform_pos)
     queue_free()
 
