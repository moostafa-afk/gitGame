extends TileMapLayer

@onready var platform = %platform

## Double check the ID in Tileset

# Use a larger area (3x3 or more) for clearing navigation polygons
func _use_tile_data_runtime_update(coords):
    # Loop over all cells in the platform layer
    for cell in platform.get_used_cells_by_id(0):  # Replace 0 with the tile ID if needed
        # Check if the target cell is within a larger radius of the current tile
        if coords.distance_to(cell) <= 2:  # Adjust the radius size here (2 means 5x5 area)
            return true
    return false

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData):
    # Set navigation polygon to null (disable navigation) for all affected tiles
    tile_data.set_navigation_polygon(0, null)
