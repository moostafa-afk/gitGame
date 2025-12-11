extends BTAction
@export var min_distance_x : int = 0

func _tick(_delta: float) -> Status:
## Player 
    var player = agent.get_tree().get_nodes_in_group("player")[0]
    
##Agent distance_x to player
    var distance_x = agent.global_position.x - player.global_position.x
    ## Just in case it is flipped left instead of right
    if distance_x < 0:
        distance_x *= -1
        
    if distance_x <= min_distance_x:

        return FAILURE
    else:
       return RUNNING
 
