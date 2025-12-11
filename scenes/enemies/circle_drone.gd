extends CharacterBody2D
@export var speed : Vector2

func _ready() -> void:
    
    pass
    
func _physics_process(delta: float) -> void:
    
    velocity.x += speed.x
    move_and_slide()
