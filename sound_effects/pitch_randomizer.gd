extends AudioStreamPlayer2D
@export var low: = 1.2
@export var high: = 1.4

func _physics_process(_delta: float) -> void:
    if self.playing == true:
        pitch_scale = randf_range(low,high)
    
