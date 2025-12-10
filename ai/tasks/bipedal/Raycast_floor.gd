extends BTAction


func _tick(_delta: float) -> Status:
        
## Checks if it collides with wall first
    if agent.is_on_wall():
       # print("wall")
        return FAILURE
    var ray_right = agent.get_node("check_on_floor").get_node("ray_right")
    var ray_left = agent.get_node("check_on_floor").get_node("ray_left")
    
## Check raycast if BOTH raycasts are colliding
    if ray_right.is_colliding() and ray_left.is_colliding():
        return SUCCESS
        
    else: 
      #  print("raycast not on floor and body not near wall")
      return FAILURE
