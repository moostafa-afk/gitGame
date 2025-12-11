extends Node
class_name CharacterController

@onready var parent_node = %ch_body
@onready var animation_player = %AnimationPlayer
@onready var coll_anim = %coll_anim
@onready var child_nodes = parent_node.get_children()

enum State { IDLE, WALK }
var current_state: State = State.IDLE

var allowed_prefixes = ["walk", "idle"]
var coll_poly = []

func _ready() -> void:
    update_state(State.IDLE)

func _physics_process(delta: float) -> void:
    update_state(get_state_from_velocity())
    update_collisions()

func get_state_from_velocity() -> State:
    if %ch_body.velocity.x == 0:
        return State.IDLE
    else:
        return State.WALK

func update_state(new_state: State) -> void:
    if current_state == new_state:
        return

    current_state = new_state

    match current_state:
        State.IDLE:
            play_animation("idle", "idle_coll")
        State.WALK:
            play_animation("walk", "walk_coll")

func play_animation(anim: String, coll_anim_name: String) -> void:
    animation_player.play(anim)
    coll_anim.play("auto/" + coll_anim_name)
    coll_anim.seek(animation_player.current_animation_position, true)

func update_collisions() -> void:
    coll_poly.clear()
    
    for coll in child_nodes:
        if coll is CollisionPolygon2D:
            coll_poly.append(coll)
            var is_allowed = allowed_prefixes.any(func(p): return coll.name.begins_with(p))
            var velocity_x = %ch_body.velocity.x

            if is_allowed:
                if velocity_x == 0 and coll_anim.current_animation != "auto/idle_coll":
                    coll.disabled = false
                    coll.visible = true
                elif velocity_x != 0:
                    coll.disabled = true
                    coll.visible = false

                # Flip and reposition based on direction
                if velocity_x < 0:
                    coll.scale.x = -5
                    coll.position.x = 376
                elif velocity_x > 0:
                    coll.scale.x = 5
                    coll.position.x = 24
