@tool

extends EditorScript

func _run():
  var select = get_editor_interface().get_selection().get_selected_nodes()
  var parent_node = select[0]
  var child = parent_node.get_children()
  for i in range(child.size ()) :
      var lol = child[i]
      lol.position = Vector2(0,0) 
    
    
    
