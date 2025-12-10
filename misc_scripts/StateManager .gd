extends Node
class_name  StateManager

enum State {IDLE,WALK,DASH} #states are here
var current_state: State = State.IDLE
@onready var child_nodes = %ch_body.get_children()

func _physics_process(delta: float):
        pass
    
func update_state(new_state : State):

    if current_state == new_state:
# Return exits the whole function, doesn't read the rest of the code
       return 
        
    current_state = new_state

    if current_state == State.IDLE:
        _play("idle","idle_coll")
    
    elif current_state == State.WALK:
        _play("walk","walk_coll2")
    
    elif current_state == State.DASH:
        _play("dash","dash_coll")
        
    
    

        
      
func _play(anim: String, coll_anim: String):
    %AnimationPlayer.play(anim)
    %coll_anim.play("auto/"+ coll_anim)
    %coll_anim.seek(%AnimationPlayer.current_animation_position,true)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
