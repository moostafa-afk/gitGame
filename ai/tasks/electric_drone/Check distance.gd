extends BTAction

@export var min_distance : int = 0

func _tick(_delta: float) -> Status:
## Player 
    var player = agent.get_tree().get_nodes_in_group("player")[0]
    
##Agent distance to player
    var distance = agent.global_position.distance_to(player.global_position)
    
    if distance <= min_distance:
        return FAILURE
    else:
       return RUNNING
    
    
    
    
    
    
    
    
