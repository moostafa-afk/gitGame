@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
    var selected_nodes = get_editor_interface().get_selection().get_selected_nodes()
    
    
    var parent_node = selected_nodes[0]
    var child_nodes = parent_node.get_children()
    print ("Parent node name is: ",parent_node.name)
    print("Children are:")
    for shape in child_nodes:
        print(shape.name)
    
    
    

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    
    
    
    
    
    
    
    
    
    
    
    
        
