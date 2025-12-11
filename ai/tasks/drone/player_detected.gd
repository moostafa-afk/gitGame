extends BTAction
var timer := 0.
var player_detected := false
var direction

func _tick(delta: float) -> Status:
    var player = agent.get_tree().get_first_node_in_group("player")
    
    timer += delta
    var ray = agent.get_node("line_of_sight")

    if not ray.get_collider() is Player:
        return RUNNING  
        
    else:
        return SUCCESS
    

    
    
