
############ Note I set the initial modulation via code within the _ready function

extends TileMapLayer
@onready var player := get_tree().get_first_node_in_group("player")
@onready var platform := get_tree().get_first_node_in_group("platforms")
@onready var electric := get_tree().get_first_node_in_group("electric")
var block_list : Array = []
var left_most_value := Vector2i.ZERO
var right_most_value := Vector2i.ZERO
var player_direction : int = 0
var delete_electric := false
var change_color_flag = false
var G := 0.0
var R := .1

func _ready() -> void:
    player_direction = player.facing_direction
    %block_remove.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:

    if %block_remove.time_left < 2.5 and change_color_flag == false:
        %change_color.start()
        change_color_flag = true
    add_to_list()
    #flip_sides()
    if Input.is_action_pressed("block"):
        %add_right.start()

    #else:
        #print("yes it has stopped")
        #%add_left.stop()
        
func _on_block_timer_timeout() -> void:
    delete_electric = true
    print("block deleted")
    call_deferred("queue_free")

func add_to_list():
    for block in self.get_used_cells():
        ## add the x value of the blocks to the list
        block_list.append(block)

func add_left_block():
    left_most_value = block_list.min()
    set_cell(Vector2i(left_most_value.x-1,left_most_value.y), 0, Vector2i(0, 0), 0)
    
func add_right_block():
    right_most_value = block_list.max()
    set_cell(Vector2i(right_most_value.x + 1,right_most_value.y), 0, Vector2i(0, 0), 0)

func _on_add_block_timer_timeout() -> void:
    if not %left.is_colliding() and player_direction <0: 
        add_left_block()
        
    if not %right.is_colliding() and player_direction >0: 
        add_right_block()
          
func turn_off_left():
    if is_instance_valid(electric):
        electric.get_node("raycasts/up_down_right").enabled = false

#func change_hue():
    #modulate = Color(.75 + R , .85 - G, .85 - G)  # Tint reddish
    #G += .0025
    #R += .17
    #
#func _on_change_color_timeout() -> void:
    #change_hue()
