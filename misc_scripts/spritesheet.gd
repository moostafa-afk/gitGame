@tool
extends EditorScript

# Define the spacing distance
var spacing = 50  # Distance between each collision shape

func _run():
    # Get the current editor selection
    var selected_nodes = get_editor_interface().get_selection().get_selected_nodes()
    
    if selected_nodes.size() > 0:
        var parent_node = selected_nodes[0]  # Assuming you selected the parent node
        
        # Debugging: Print the selected parent node name
        print("Selected parent node: ", parent_node.name)
        
        if parent_node:
            # Check if parent node has children
            var child_nodes = parent_node.get_children()
            print("Number of child nodes: ", child_nodes.size())  # Debugging: Print number of children
            
            if child_nodes.size() == 0:
                print("No child nodes found under parent.")
            
            # Set the initial X position
            var x_offset :int = 0
            
            # Loop through the child nodes and position the collision shapes
            for shape in child_nodes:
                print("Node name: ", shape.name, ", Node type: ", shape.get_class())  # Debugging: print node type
                
                # Check if it's a CollisionShape2D or CollisionPolygon2D
                if shape is CollisionShape2D or shape is CollisionPolygon2D:
                    print("Moving collision node: ", shape.name)  # Debugging: Print each collision shape's name
                    shape.position = Vector2(x_offset, 0)  # Set Y to 0 for horizontal alignment
                    x_offset += spacing  # Increase X position by spacing
                else:
                    print("Skipping non-collision node: ", shape.name)  # Debugging: non-collision shapes
    else:
        print("No parent node selected.")  # Debugging: No node is selected
