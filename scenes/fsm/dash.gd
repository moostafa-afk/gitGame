extends State
class_name Dash

var direction := 1  # Default facing direction
var is_dashing := false
@export var dash_speed := 200


func Enter():
    print("dash_pressed")
    invisible()
    %dash.visible = true

    is_dashing = true
    direction = player.facing_direction  # Capture direction ONCE here
    if direction == 0:
        direction = 1  # Default fallback

    %DashTimer.start()
    %AnimationPlayer.play("dash")

func Update(_delta):
    if is_dashing:
        player.velocity.x = dash_speed * direction
        
    if not player.is_on_floor():
            state_transition.emit(self,"Fall")
                


func _on_dash_timer_timeout() -> void:

# We put transition here so that it can finish the animation first before transitioning 
    is_dashing = false
            # TRANSITION based on input at the end of dash
    if player.velocity.x == 0:
        state_transition.emit(self, "Idle")
    elif player.velocity.x != 0:
        state_transition.emit(self, "Move")



        
        
        
        
        
        
        
        
