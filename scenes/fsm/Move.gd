extends State
class_name Move
var direction := 1 
var move_is_held:= false
var SH_Jump = false

@export var speed := 1000


func Enter(): 
# Don't call `play("run")` again if it's already playing

    print("move")
    invisible()

    %walk.visible = true
    %AnimationPlayer.play("walk")

func Update(_delta): 
    
    if not player.is_on_floor():
        state_transition.emit(self,"Fall")
        return
                
    elif player.is_on_floor():
    ##Here I'm setting the direction to the player input
        direction = player.direction # SHORTCUT   

        if direction != 0:
            player.velocity.x = speed * direction 
            if %MoveHeld.is_stopped(): %MoveHeld.start()
            
    ##if no direction is pressed
        elif direction == 0:
            player.velocity.x = 0
            %MoveHeld.stop()
            move_is_held = false
            state_transition.emit(self, "Idle")       
            return 
        if Input.is_action_just_pressed("jump") :
            state_transition.emit(self,"SJump")
            return
        elif Input.is_action_just_pressed("super_jump") :
    ## Use is stopped then start to prevent  it from constantly restarting 
            state_transition.emit(self,"JumpController")
            return

        ##The timer is using  one shot so that it doesn't always rrstart 
        elif Input.is_action_just_pressed("dash"):
            state_transition.emit(self, "Dash")
            return 




func Move_Held_timeout() -> void:
    if player.is_on_floor() and player.velocity.x != 0:
        move_is_held = true
        print("M is held")
    
    
    
    
    
