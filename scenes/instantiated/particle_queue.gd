extends GPUParticles2D

func _ready() -> void:
    one_shot = true
    
    if self.lifetime == 0.:
        queue_free()
        
