extends TileMapLayer


func _ready() -> void:
    
##  changes the positions to tile map cooridinates 
    

## Setting the area cells to all of the platfrom cells
    for platform_pos in %platform_destr.get_used_cells():
        %delete_tiles.set_cell(platform_pos, 0, Vector2i(0, 0), 0)
 
