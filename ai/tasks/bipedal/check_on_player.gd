extends BTAction

func _tick(_delta: float) -> Status:   
## Checks if it collides with wall first

    var ray_right = agent.get_node("check_on_player").get_node("ray_right")
    var ray_left = agent.get_node("check_on_player").get_node("ray_left")
    
## Check raycast if BOTH raycasts are colliding
    if ray_right.is_colliding() or ray_left.is_colliding():
        agent.get_node("Hitbox").monitoring = true
        return SUCCESS
        
    else: 
        if !ray_right.is_colliding() or !ray_left.is_colliding():
            agent.get_node("Hitbox").monitoring = false
        return FAILURE
