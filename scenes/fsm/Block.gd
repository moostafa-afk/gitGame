extends State
class_name Block
@export var block_num : int = 3
var block_list : Array = []
# Called when the node enters the scene tree for the first time.

func Enter():
    
   player.velocity.x = 0
   print("block")
   owner.add_block.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(_delta):

    if not player.is_on_floor():
## Prevents more than one block from being added when falling
        state_transition.emit(self,"Fall")
    
    if player.is_on_floor():
        if player.direction: 
           state_transition.emit(self, "Move")

        elif Input.is_action_just_pressed("dash"):
            state_transition.emit(self, "Dash")
        
        elif player.direction == 0:
            state_transition.emit(self,"Idle")
            

             


    
    









    
    
