extends TileMapLayer



func _use_tile_data_runtime_update(coords):
    if coords in %platform.get_used_cells_by_id(0):  # Replace 0 with the tile ID if needed
            return true
    return false

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData):
    # Set navigation polygon to null (disable navigation) for all affected tiles
        tile_data.set_navigation_polygon(0,null)
    
    
    
    
    
    
    
    
    
    
