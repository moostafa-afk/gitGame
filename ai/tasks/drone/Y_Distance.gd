extends BTAction
@export var min_distance_y : int = 0

func _tick(_delta: float) -> Status:
## Player 
    var player = agent.get_tree().get_nodes_in_group("player")[0]
    
##Agent distance_x to player

    var distance_y = agent.global_position.y - player.global_position.y
    ## Just in case it is flipped lef instead of right

    if distance_y <= min_distance_y:
        return SUCCESS
    else:
       return RUNNING
 
