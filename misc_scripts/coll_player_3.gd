@tool
extends Node

@export var anim_player_path: NodePath
@export var animation_name: String = "idle_coll"
@export var animation_library_name: String = "default"

func _ready():
    if Engine.is_editor_hint():
        generate_animation()

func generate_animation():
    var anim_player: AnimationPlayer = get_node_or_null(anim_player_path)
    if not anim_player:
        push_error("AnimationPlayer not found at path: " + str(anim_player_path))
        return

    var anim_library: AnimationLibrary
    if not anim_player.has_animation_library(animation_library_name):
        anim_library = AnimationLibrary.new()
        anim_player.add_animation_library(animation_library_name, anim_library)
        print("Created animation library:", animation_library_name)
    else:
        anim_library = anim_player.get_animation_library(animation_library_name)

    if anim_library.has_animation(animation_name):
        anim_library.remove_animation(animation_name)
        print("Replaced existing animation:", animation_name)

    var animation = Animation.new()
    var child_nodes = get_children()
    animation.length = child_nodes.size() * 0.1

    for i in range(child_nodes.size()):
        var child = child_nodes[i]
        if not child is Node:
            continue

        var start_time = i * 0.1

        animation.add_track(Animation.TYPE_VALUE)
        animation.add_track(Animation.TYPE_VALUE)

        var rel_path = anim_player.get_path_to(child)
        var disabled_path = NodePath(str(rel_path) + ":disabled")
        var visible_path = NodePath(str(rel_path) + ":visible")

        animation.track_set_path(i * 2, disabled_path)
        animation.track_set_path(i * 2 + 1, visible_path)

        animation.track_set_interpolation_type(i * 2, Animation.INTERPOLATION_NEAREST)
        animation.track_set_interpolation_type(i * 2 + 1, Animation.INTERPOLATION_NEAREST)

        animation.track_insert_key(i * 2, start_time, false)
        animation.track_insert_key(i * 2 + 1, start_time, true)
        animation.track_insert_key(i * 2, start_time + 0.1, true)
        animation.track_insert_key(i * 2 + 1, start_time + 0.1, false)

        print("Keyframes added for:", child.name, "at", str(start_time), "s")

    anim_library.add_animation(animation_name, animation)
    print("Animation created:", animation_name)

    var anim_path = animation_library_name + "/" + animation_name
    if anim_player.has_animation(anim_path):
        var loop_anim = anim_player.get_animation(anim_path)
        loop_anim.loop = true
        print("Set animation to loop.")
