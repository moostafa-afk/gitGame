@tool
extends EditorScript

func _run() -> void:
    var selected_nodes = get_editor_interface().get_selection().get_selected_nodes()
    
    if selected_nodes.is_empty():
        print("No nodes selected!")
        return
    
    var parent_node = selected_nodes[0]
    var child_nodes = parent_node.get_children()
    
    if child_nodes.is_empty():
        print("No children found in the selected node.")
        return
    
    # Search for AnimationPlayer in the scene tree
    var anim_player: AnimationPlayer = parent_node.get_node_or_null("../coll_anim")
    if not anim_player:
        print("AnimationPlayer not found! Make sure it's in the parent or root.")
        return
    
    # Get or create the default animation library
    var library_name = "default"
    if not anim_player.has_animation_library(library_name):
        anim_player.add_animation_library(library_name, AnimationLibrary.new())
        print("Created new animation library: 'default'")
    
    var anim_library = anim_player.get_animation_library(library_name)
    
    # Create or replace the animation
    var anim_name = "idle_coll"
    if anim_library.has_animation(anim_name):
        anim_library.remove_animation(anim_name)
        print("Removed existing animation: " + anim_name)

    var animation = Animation.new()
    animation.length = child_nodes.size() * 0.1
    
    # Loop through children and add disabled and visibility property keys
    for i in range(child_nodes.size()):
        var child = child_nodes[i]
        var start_time = i * 0.1
        
        # Add tracks for both disabled and visible properties
        animation.add_track(Animation.TYPE_VALUE)  # Track for "disabled"
        animation.add_track(Animation.TYPE_VALUE)  # Track for "visible"
        
        # Convert paths to string and add :disabled and :visible properties
        var disabled_path = str(child.get_path()) + ":disabled"
        var visible_path = str(child.get_path()) + ":visible"
        
        animation.track_set_path(i * 2, disabled_path)  # Set disabled track path
        animation.track_set_path(i * 2 + 1, visible_path)  # Set visible track path
        
        # Set interpolation mode to discrete for both tracks
        animation.track_set_interpolation_type(i * 2, Animation.INTERPOLATION_NEAREST)
        animation.track_set_interpolation_type(i * 2 + 1, Animation.INTERPOLATION_NEAREST)
        
        # Set keyframes for disabling the node and toggling visibility
        animation.track_insert_key(i * 2, start_time, false)  # Disable the node
        animation.track_insert_key(i * 2 + 1, start_time, true)  # Set visibility to true
        animation.track_insert_key(i * 2, start_time + 0.1, true)  # Enable the node
        animation.track_insert_key(i * 2 + 1, start_time + 0.1, false)  # Set visibility to false
        
        # Simplified debug output
        print("Keyframes added for: " + child.name + " at time: " + str(start_time) + "s")
        
    # Add the animation to the library
    anim_library.add_animation(anim_name, animation)
    print("Added animation to library: " + anim_name)
    
    # Play the animation by specifying the library and animation name
    var animation_path = library_name + "/" + anim_name
    if anim_player.has_animation(animation_path):
        anim_player.play(animation_path)
        print("Playing animation: " + animation_path)
    else:
        print("ERROR: Animation not found in player: " + animation_path)  
    
    # Loop the animation
    var animation_loop = anim_player.get_animation(animation_path)
    animation_loop.loop = true  
    if animation_loop:
        print("Animation set to loop!")
