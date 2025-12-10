#direction = player.direction in update
extends State
class_name JumpController
var direction := 0
var current_substate: Node = null
var is_held = false
var from_jump = true
@onready var fsm = %FSM

func Enter():
    print("JumpController")
    invisible()
    %jump_ready.visible = true
    player.velocity.x = 0

## Used to find the substates 
    for child in get_children():
        if child.has_signal("state_transition") and not child.state_transition.is_connected(_on_substate_transition):
            child.state_transition.connect(_on_substate_transition)

func Update(delta):
    buffer_coyote()
    var time_held :float = %JumpTimer.wait_time - %JumpTimer.time_left
    %Fall.Midair_speed()
    
    ##For block platform
    if Input.is_action_just_pressed("block"):
        state_transition.emit(self,"block")

 ##  To stop leftover momentum
        player.velocity.x = 0
        
##  We use timer stop here, cuz jump pressed works before release
    if %Move.move_is_held and Input.is_action_just_released("super_jump"):
        set_substate("HJump")
        %Move.move_is_held = false
        %MoveHeld.stop()
        %JumpTimer.stop()
        ## %Move.move_is_held = false 
        ##This reset only works in HJump Update for some reason
        return
    
    
    if not player.is_on_floor() and Input.is_action_just_pressed("super_jump"):
        %jump_buffer.start()
        %JumpTimer.stop()
    elif player.is_on_floor():   
        player.velocity.x = 0   

## just pressed doesn't work if seems that in the frame it transitions, it doesn't equal true in the frame after

## When (pressing super_jump) OR when (buffered and pressing super_jump), the timer goes off
        if Input.is_action_pressed("super_jump")  or (%jump_buffer.time_left >0 and Input.is_action_pressed("super_jump")):
### These three visibilty lines are here to prevent the jump sprite from showing while pressing after the bugger
            %L_jump.visible = false
            %M_jump.visible = false
            %jump_ready.visible = true
            if %JumpTimer.is_stopped(): %JumpTimer.start()
            
        ## If ((buffer flag is true is true) AND  (jump released)) and buffer time greater than zero

            #print("the problem is with jump buffered")
        elif %jump_buffer.time_left > 0:
            print("buffer entered")
            if is_held:
                set_substate("LJump")
                is_held = false
            elif time_held <= %JumpTimer.wait_time * (2./3.)  or time_held == .6:
                set_substate("SJump")
            elif time_held >= %JumpTimer.wait_time * (2./3.):
             set_substate("MJump")   
             return

        ## Normal jump this time without considdering the buffers
        elif Input.is_action_just_released("super_jump") :
            %JumpTimer.stop()
            if is_held:
                set_substate("LJump")
                is_held = false
            elif time_held <= %JumpTimer.wait_time * (2./3.) :
                set_substate("SJump")
            elif time_held > %JumpTimer.wait_time * (2./3.):
                set_substate("MJump")


        elif %jump_buffer.time_left == 0.:
            state_transition.emit(self,"Idle")
            return


## Must add FSM before current_substate and set_substate
    if current_substate != null:
        current_substate.Update(delta)   
        
func _on_jump_timer_timeout() -> void:
    is_held = true
## To prevent move_is_held from being true ,casuing and Hjump and an LJump
    %Move.move_is_held = false
    print("held")
    

    
## No variable needed here its too much of a hassle, instead i just use .time_left......  .start() starts in the fall state after pressing jump midair


func buffer_coyote():
## Enter Coyote Jump From Fall
    if %Fall.coyote_jump:
        %Fall.coyote_jump = false
        %coyote_timer.stop()
        

#region Substate stuff
func set_substate(substate_name: String):
    if current_substate:
        current_substate.Exit()
        current_substate = null

    var sub = get_node_or_null(substate_name)
    if sub == null:
        sub = find_child(substate_name, true, false)

    if sub:
    #    print("Setting substate to:", substate_name)
        current_substate = sub
        current_substate.Enter()
        
    else:
        
         printerr("Substate not found:", substate_name)
    
func Exit():
    if current_substate:
        current_substate.Exit()
    
    current_substate = null

func _on_substate_transition(_from_state, to_state_name: String) -> void:
    #print("Substate requested transition to:", to_state_name)
    state_transition.emit(self, to_state_name)
    
#endregion      
