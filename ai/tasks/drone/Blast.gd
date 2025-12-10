extends BTAction
func _enter() -> void:
## This is for recoil of the drone from the blast
    #print("blast")
## Player group and postion is here 
    var player = agent.get_tree().get_nodes_in_group("player")[0]
    #agent.get_node("laser_sound").play()

## Instance of the laser here
    var blast: PackedScene = preload("res://scenes/enemies/drone_blast.tscn")
    var inst = blast.instantiate()
    inst.global_position = agent.global_position + Vector2(0,0)
    
    
## Since add child is only possible in node here is the alternative
    agent.get_tree().current_scene.add_child(inst)
## Makes the laser start from the drone


     
