extends Sprite2D
var tween:= create_tween()
func _ready():
    tween.tween_property(self,"position", Vector2(266,-300), 5).set_trans(Tween.TRANS_CUBIC)
    
