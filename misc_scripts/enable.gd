@tool
extends EditorScript

func _run() -> void:
    var scene = get_editor_interface().get_edited_scene_root()
    if scene == null:
        push_error("No scene is currently open.")
        return

    var parent_node = scene.get_node("walk_coll")
    var anim_player = scene.get_node("coll_anim")

    if not parent_node or not anim_player:
        push_error("Could not find 'walk_coll' or 'coll_anim' in the scene.")
        return

    var child_nodes = parent_node.get_children()
    if child_nodes.is_empty():
        push_warning("No children found in 'walk_coll'")
        return

    var anim_name := "Enable_Disable_Animation"

    # Create or fetch the unnamed animation library
    var default_library: AnimationLibrary
    if anim_player.has_animation_library(""):
        default_library = anim_player.get_animation_library("")
    else:
        default_library = AnimationLibrary.new()
        anim_player.set_animation_library("", default_library)
        print("Created unnamed animation library")

    # Remove previous animation if it exists
    if default_library.has_animation(anim_name):
        default_library.remove_animation(anim_name)
        print("Removed old animation")

    var animation := Animation.new()
    animation.length = child_nodes.size() * 0.1
    animation.loop = true

    for i in range(child_nodes.size()):
        var child = child_nodes[i]
        var start_time = i * 0.1

        animation.add_track(Animation.TYPE_VALUE)
        animation.add_track(Animation.TYPE_VALUE)

        var disabled_path = str(child.get_path_to(scene)) + ":disabled"
        var visible_path = str(child.get_path_to(scene)) + ":visible"

        animation.track_set_path(i * 2, disabled_path)
        animation.track_set_path(i * 2 + 1, visible_path)

        animation.track_set_interpolation_type(i * 2, Animation.INTERPOLATION_NEAREST)
        animation.track_set_interpolation_type(i * 2 + 1, Animation.INTERPOLATION_NEAREST)

        animation.track_insert_key(i * 2, start_time, false)
        animation.track_insert_key(i * 2 + 1, start_time, true)
        animation.track_insert_key(i * 2, start_time + 0.1, true)
        animation.track_insert_key(i * 2 + 1, start_time + 0.1, false)

        print("Added keys for: ", child.name)

    default_library.add_animation(anim_name, animation)
    print("Animation created and added to animation player.")
    anim_player.assigned_animation = anim_name
