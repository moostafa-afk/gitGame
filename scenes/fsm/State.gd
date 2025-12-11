extends Node
class_name State
signal state_transition(source_state: State, new_state_name: String)
@onready var player = get_tree().get_first_node_in_group("player")
func Enter(): 
    pass

func Exit():
    pass

func Update(_delta):
    pass

## Function to set visibility of a list of nodes
func invisible():
    for sprite in %Sprites.get_children():
        sprite.visible = false

     
        
        
        
        
        
