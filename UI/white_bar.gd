extends TextureProgressBar
@onready var player := get_tree().get_first_node_in_group("player")

func _on_anim_red_bar_timeout() -> void:
    var tween := create_tween()
    var current_health = player.get_node("Health").current_health
    tween.tween_property(self,"value",current_health , .3)
    
