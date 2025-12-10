extends BTAction

@export var down_offset: =0

func _tick(_delta: float) -> Status:
    
    var player = agent.get_tree().get_nodes_in_group("player")[0]
    var up_down = int(player.global_position.y - agent.global_position.y) + down_offset
    #print(up_down)
    #print(down_offset,"this is down offset")
    
## Check player below bipedal
    if up_down > 0:
        blackboard.set_var("State", "Fall")
        #print("fall")
        
## Check player above bipedal
    elif up_down < 0:
        blackboard.set_var("State", "Jump")
        #print("jump")
        
    return FAILURE
    
