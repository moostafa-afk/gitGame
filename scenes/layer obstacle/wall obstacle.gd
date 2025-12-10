extends TileMapLayer

## This is the code for the the current navigaition tileset which is wall, and it exculudes platforms from its navigation layer
@onready var platform = %platform_destr

## Double check the ID in Tileset
func _ready() -> void:
    pass


func _use_tile_data_runtime_update(coords):
    # Loop over all cells in the platform layer
    for cell in platform.get_used_cells():  
        if coords.distance_to(cell) <= 3: 
            return true
    return false

func _tile_data_runtime_update(_coords: Vector2i, tile_data: TileData):
    tile_data.set_navigation_polygon(0, null)
