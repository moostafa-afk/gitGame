extends Node2D
signal recoil_from_blast
var recoil_flag = false
func _physics_process(delta: float) -> void:
    if recoil_flag == false:
        recoil_from_blast.emit()
        recoil_flag = true
    
