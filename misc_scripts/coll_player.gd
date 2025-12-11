#This script has to pair with animations the first node
extends Node2D #8 20 84 Change these lines
func _ready() -> void:
    
     call_deferred("create_enable_disable_animation")

func create_enable_disable_animation() -> void:
    var parent_node = %dash_coll
    var child_nodes = parent_node.get_children()

    if child_nodes.is_empty():
        print("No children found in the selected node.")
        return

    var anim_player: AnimationPlayer = %coll_anim
    if not anim_player:
        print("AnimationPlayer not found!")
        return

    var anim_name := "dash_coll"
    var library_name := "auto"

    # Get or create a named animation library
    var anim_library: AnimationLibrary
    if anim_player.has_animation_library(library_name):
        anim_library = anim_player.get_animation_library(library_name)
    else:
        anim_library = AnimationLibrary.new()
        anim_player.add_animation_library(library_name, anim_library)
        print("Created animation library:", library_name)

    # Remove old animation if it exists
    if anim_library.has_animation(anim_name):
        anim_library.remove_animation(anim_name)
        print("Removed existing animation:", anim_name)

    var animation := Animation.new()
    animation.length = child_nodes.size() * 0.1
    animation.loop = true

    for i in range(child_nodes.size()):
        var child = child_nodes[i]
        var start_time = i * 0.1
        
        animation.add_track(Animation.TYPE_VALUE)
        animation.add_track(Animation.TYPE_VALUE)
        var clean_path = %character.get_path_to(child)
        print("From AnimationPlayer to child:", clean_path)
        var disabled_path = (str(clean_path) + ":disabled")
        var visible_path = (str(clean_path) + ":visible")
    
        animation.track_set_path(i * 2, disabled_path)
        animation.track_set_path(i * 2 + 1, visible_path)

        animation.track_set_interpolation_type(i * 2, Animation.INTERPOLATION_NEAREST)
        animation.track_set_interpolation_type(i * 2 + 1, Animation.INTERPOLATION_NEAREST)

        animation.track_insert_key(i * 2, start_time, false)
        animation.track_insert_key(i * 2 + 1, start_time, true)
        animation.track_insert_key(i * 2, start_time + 0.1, true)
        animation.track_insert_key(i * 2 + 1, start_time + 0.1, false)

        print("Keyframes added for:", child.name, "at time:", start_time)

    anim_library.add_animation(anim_name, animation)
    print("Added animation to library:", library_name)

    # Save animation to disk
    var save_path = "res://animations/" + anim_name + ".anim"
    var save_result = ResourceSaver.save(animation, save_path)
    if save_result == OK:
        print("Animation saved to:", save_path)
    else:
        print("Failed to save animation:", save_result)

    # Play it using full name: library/animation
    var full_anim_path := library_name + "/" + anim_name
    if anim_player.has_animation(full_anim_path):
        anim_player.play(full_anim_path)
        print("Playing animation:", full_anim_path)
    else:
        print("ERROR: Animation not found:", full_anim_path)
        
    var anim = load("res://animations/dash_coll.anim")
    %coll_anim.get_animation_library("auto").add_animation("auto",anim)    
    
    
    
    
    
    
    
    
        
