extends Sprite2D
@onready var drone: Node = get_tree().get_first_node_in_group("drone")
func _ready() -> void:
    
    %FireBlast.play()
func _physics_process(delta: float) -> void:

    if drone :
        if drone.has_node("thruster"):
             drone.get_node("thruster").emitting = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    
    if anim_name == "flames" and drone and drone.has_node("thruster"):
        drone.get_node("thruster").emitting = true
        owner.queue_free()
