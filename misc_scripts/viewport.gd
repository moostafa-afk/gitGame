@tool
extends EditorScript

# Function to animate collision shapes sequentially
func animate_collision_shapes_sequentially(animation_player: AnimationPlayer, parent_node: Node, animation_name: String) -> void:
    # Check if the AnimationPlayer exists
    if not animation_player:
        print("AnimationPlayer not found!")
        return
    
    # Create a new animation
    var animation = Animation.new()
    animation.length = parent_node.get_child_count()  # Set animation length based on the number of collision shapes
    
    # Add the animation to the AnimationPlayer
    if not animation_player.has_animation_library(""):
        animation_player.add_animation_library("", AnimationLibrary.new())
    animation_player.get_animation_library("").add_animation(animation_name, animation)
    
    # Get all child collision shapes of the parent node
    var collision_shapes = []
    for child in parent_node.get_children():
        if child is CollisionShape2D or child is CollisionPolygon2D:
            collision_shapes.append(child)
    
    # Iterate through each collision shape
    for i in range(collision_shapes.size()):
        var shape = collision_shapes[i]
        var shape_path = animation_player.get_path_to(shape)
        
        # Add a track for the "disabled" property
        var disabled_track = animation.add_track(Animation.TYPE_VALUE)
        animation.track_set_path(disabled_track, shape_path + ":disabled")
        
        # Set keyframes for the "disabled" property
        for frame in range(collision_shapes.size()):
            var disabled_value = (frame != i)  # Disable all shapes except the current one
            animation.track_insert_key(disabled_track, float(frame), disabled_value)
        
        print("Added animation for shape {i}: {shape.name}")

# Recursive function to find a node by name
func find_node_recursive(root: Node, node_name: String) -> Node:
    if root.name == node_name:
        return root
    for child in root.get_children():
        var result = find_node_recursive(child, node_name)
        if result:
            return result
    return null

# Run the tool script in the editor
func _run():
    # Get the current scene
    var scene = get_scene()
    if not scene:
        print("No scene loaded!")
        return
    
    # Find the AnimationPlayer node
    var animation_player = find_node_recursive(scene, "AnimationPlayer")
    if not animation_player:
        print("AnimationPlayer node not found in the scene!")
        return
    
    # Find the parent node (output)
    var parent_node = find_node_recursive(scene, "output")
    if not parent_node:
        print("Parent node 'output' not found in the scene!")
        return
    
    # Replace "sequential_animation" with the name of your animation
    var animation_name = "sequential_animation"
    
    # Call the function to set up the sequential animation
    animate_collision_shapes_sequentially(animation_player, parent_node, animation_name)
    
    print("Sequential animation created successfully!")
