extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

#makes it transparent
func _on_left_pressed() -> void:
    %left.modulate.a = .3 
#makes it normal
func _on_left_released() -> void:
    %left.modulate.a = 1
    
func _on_right_pressed() -> void:
    %right.modulate.a = .3

func _on_right_released() -> void:
    %right.modulate.a = 1

func _on_dash_pressed() -> void:
    %left.modulate.a = .3

func _on_dash_released() -> void:
    %left.modulate.a = 1

func _on_jump_pressed() -> void:
    %left.modulate.a = .3
    
func _on_jump_released() -> void:
    %left.modulate.a = 1
