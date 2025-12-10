extends Node

@onready var parent_node = %ch_body
@onready var state_manager = %StateManager
@onready var body = %ch_body # Must have `velocity` and be a CharacterBody2D-like node

var allowed_prefixes = ["walk", "idle", "dash"]

func _ready() -> void:
    pass
    #print(Engine.get_frames_per_second())

func _physics_process(delta: float) -> void:
    update_coll(delta)

func update_coll(delta: float) -> void:
    for coll in parent_node.get_children():
        if coll is CollisionPolygon2D and allowed_prefixes.any(func(prefix): return coll.name.begins_with(prefix)):
            # Default: disable everything first
            coll.disabled = true
            coll.visible = false

            if coll.name.begins_with("idle"):
                coll.disabled = false
                coll.visible = true
                state_manager.update_state(state_manager.State.IDLE)

            elif coll.name.begins_with("walk") and body.velocity.x != 0:
                coll.disabled = false
                coll.visible = true
                state_manager.update_state(state_manager.State.WALK)

                # Flip based on direction
