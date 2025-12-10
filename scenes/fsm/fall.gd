extends State
class_name Fall
var direction := 0
var coyote_jump :bool = false
var jump_buffer := false
@export var midair_speed := 600
@export var gravity = 1000
var current_substate: Node = null

func Enter():
    print("fall")
    # TODO When entering u gotta add an animation for falling
## Coyote timer here to prevent it from restarting in update
    if %coyote_timer.is_stopped  :
          %coyote_timer.start()
    pass
    
    
func Update(_delta):
    Midair_speed()
    block()
    on_the_floor()
    if player.velocity.y < 0 and %SJump.s_released == false:
        if Input.is_action_just_released("jump"):
            player.velocity.y *= .65
    if Input.is_action_just_pressed("jump"):
        jump_buffer = true
    
    if %coyote_timer.time_left > 0 and Input.is_action_just_pressed("super_jump") and player.velocity.y > 0:
        coyote_jump = true
        state_transition.emit(self, "JumpController")
    elif %coyote_timer.time_left > 0 and Input.is_action_just_pressed("jump")  and player.velocity.y > 0:
        coyote_jump = true
        state_transition.emit(self, "SJump")
    
func on_the_floor():
    
    if player.is_on_floor():
        if jump_buffer == true:
            jump_buffer = false
            state_transition.emit(self,"SJump")
## After landing on the ground player can add blocks 
        %coyote_timer.stop()   
        %jump_buffer.stop()
        if player.direction: 
           state_transition.emit(self, "Move")

        elif Input.is_action_just_pressed("dash"):
            state_transition.emit(self, "Dash")
        
        elif player.direction == 0:
            state_transition.emit(self,"Idle")
            

## Gravity with a capital G cuz there is a  var called gravity (lowercase)
func Gravity(delta):
    if not player.is_on_floor():
        
        if player.velocity.y < 0: ##moving up gravity is low
            player.velocity.y += gravity * delta
        elif player.velocity.y >= 0: ##moving down gravity is high
            player.velocity.y  += gravity  * 2.5 * delta


func Midair_speed():
  
##Here I'm setting the direction to the player input
    direction = player.direction # SHORTCUT 
    
##Is inputing direction
##Not to be confused with facing direction    
    if direction != 0 and !player.is_on_floor():
        player.velocity.x =   midair_speed * direction
        
func block():
    ##For block platform
    if Input.is_action_just_pressed("block"):
        state_transition.emit(self,"block")
    
