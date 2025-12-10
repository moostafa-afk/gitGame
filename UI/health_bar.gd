extends TextureProgressBar
var connect_once := false
@onready var player := get_tree().get_first_node_in_group("player")
##  Ill uses process for continous damage like electric
func _process(_delta: float) -> void:
    
    var current_health = player.get_node("Health").current_health
    if value != current_health:
        value = current_health
        %anim_red_bar.start()
        
    

    
#TODO: Addd animation for the flash here
## For the animation of the flash

#func on_damage_taken():
    ### Restarts the timer if there are consecutive hits
        #%red_bar.start()
        

    
