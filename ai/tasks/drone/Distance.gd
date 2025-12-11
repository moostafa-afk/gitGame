extends BTAction
@export var min_distance = 10
func _tick(delta: float) -> Status:
    var player = agent.get_tree().get_nodes_in_group("player")[0]
    var distance = agent.global_position.distance_to(player.global_position)
    if distance < min_distance:
        return SUCCESS
    else:
      return FAILURE
    
    
