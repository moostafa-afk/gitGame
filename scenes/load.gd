extends Node2D

@onready var anim_player: AnimationPlayer = %coll_anim

func _ready() -> void:
    var anim_path := "res://animations/idle_coll.tres"
    var anim := load(anim_path) as Animation
    if anim == null:
        print("Failed to load animation from:", anim_path)
        return

    var lib_name := "auto"
    var library: AnimationLibrary

    if anim_player.has_animation_library(lib_name):
        library = anim_player.get_animation_library(lib_name)
    else:
        library = AnimationLibrary.new()
        anim_player.add_animation_library(lib_name, library)
        print("Created new AnimationLibrary:", lib_name)

    library.add_animation("idle_coll", anim)
    anim_player.play("auto/idle_coll")
    print("Playing animation: auto/idle_coll")
