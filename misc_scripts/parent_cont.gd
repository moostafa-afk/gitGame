@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
    var selcted_nodes = get_editor_interface().get_selection().get_selected_nodes()
    if selected_nodes :
        
