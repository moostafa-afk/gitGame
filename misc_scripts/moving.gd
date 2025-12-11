@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
   var selection =  get_editor_interface().get_selection().get_selected_nodes()
   var parent = selection[0]
   var children = parent.get_children()
   var root = get_editor_interface().get_edited_scene_root()

   for i in children:
    parent.remove_child(i)
    root.get_node("ch_body").add_child(i)
