
## This script makes it so if the player is in the air for long enough the bipedal will fall

extends BTAction
var timer := 0.0
@export var max_air_time : = .2
var timer_has_started = false

func _tick(delta: float) -> Status:
## Timer
    #print(round_place(timer,1))
    
## Connect the signal
    
    if not agent.player.is_connected("player_on_block", on_player_block):
         agent.player.connect("player_on_block", on_player_block)
     
    if timer_has_started == true :
        timer += delta
        if timer > max_air_time:
            agent.set_collision_mask_value(5, false)     
            timer_has_started == false
    return RUNNING
    
## If the player is on the block this func will then work 
func on_player_block(is_on_block):
        if is_on_block == true:
            timer_has_started = false
            timer = 0
            agent.set_collision_mask_value(5, true)
        else:
            timer_has_started = true
            #agent.set_collision_mask_value(5, false)

func round_place(num,places):
    return (round(num*pow(10,places))/pow(10,places))
    
