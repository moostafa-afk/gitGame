extends BTAction
@export var Jump : int = 1000
func _tick(_delta: float) -> Status:
## The opposite of Fall
 
    if agent.is_on_floor():
        agent.velocity.y = -Jump 
        #print(agent.velocity.y)
        return SUCCESS
        
    else:

        return FAILURE
        
