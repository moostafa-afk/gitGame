extends Area2D
 
var expand : bool

func _physics_process(delta: float) -> void:
    
    if expand:
        scale.x += 3
    pass

func _on_body_entered(body: Node2D) -> void:
    
    if body.is_in_group("platforms"):
       var expand = true
