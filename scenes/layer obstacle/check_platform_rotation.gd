extends TileMapLayer

var dictionary := {}
signal rotate(rotated_cells)

func update_cell():
    
    for cell in get_used_cells():
        if is_cell_transposed(cell):
            dictionary[cell] = "rotated"
            rotate.emit(dictionary[cell])
        else:
            dictionary[cell] = "not_rotated"
            rotate.emit(dictionary[cell])

#func _on_timer_timeout() -> void:
    #call_deferred("update_cell")
