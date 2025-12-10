extends State
class_name Idle
@export var animator : AnimationPlayer
@export var buffer_time := 0

func Enter():
    print("idle")
    invisible() 
    %idle.visible = true
    animator.play("idle")
    
            
    pass
    
func Update(_delta : float):
    player.velocity.x = 0

#Is inputing direction
#Not to be confused with facing direction 
    if player.is_on_floor():
        
        if player.direction: 
           state_transition.emit(self, "Move")

        elif Input.is_action_just_pressed("dash"):
            state_transition.emit(self, "Dash")
            
        elif Input.is_action_just_pressed("jump") :
            state_transition.emit(self, "SJump")
            
        elif Input.is_action_just_pressed("super_jump") :
            state_transition.emit(self, "JumpController")
            

    if not player.is_on_floor() :
              %coyote_timer.start()
              state_transition.emit(self,"Fall")
            
