extends BTAction
@export var instance : PackedScene 
func _enter() -> void:
## Player group and postion is here 
    var player = agent.get_tree().get_nodes_in_group("player")[0]

## Instance of the laser here
    #var load_laser: PackedScene = preload("res://scenes/enemies/laser.tscn")
    var inst = instance.instantiate()
    inst.global_position = agent.global_position
    
## Since add child is only possible in node here is the alternative
    agent.get_tree().current_scene.add_child(inst)
## Makes the laser start from the drone


     
