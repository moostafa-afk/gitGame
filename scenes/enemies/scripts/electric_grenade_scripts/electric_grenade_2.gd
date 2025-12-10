extends Area2D

var direction := Vector2.ZERO
@export var speed := 500
@export var spread : = 1
var touch_platform :=false
var timer_flag := false
var dictionary := {}
var right_flag: = false
var left_flag := false
var on_plat_block := false
var G :float = 0.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var blocks : TileMapLayer = get_first_block()
@onready var platform := get_tree().get_nodes_in_group("platforms")[0]
@onready var ground := get_tree().get_first_node_in_group("ground")
@export var damage : float = .01
var player_entered_trap = false

func _ready():

    rotated()
    direction = (player.global_position - self.global_position).normalized()
    %Sprite2D.rotation = direction.angle()
    %coll_right.shape = RectangleShape2D.new()
    %coll_right.shape.extents = Vector2(14,14)
    %coll_left.shape = RectangleShape2D.new()
    %coll_left.shape.extents = Vector2(14,14)

func _physics_process(delta: float) -> void:
    
    entered_trap()


    if touch_platform == false:
        self.global_position += speed * direction * delta
    if touch_platform == true :
    #TODO: Will have to work on this later on my free time, sometimes it deletes other times it doesnt
        #delete_self()
        
        speed = 0
        if %up.is_colliding() :
            if check_loop_rotated(%up) == true:
               right_left_invisible() 
               expand_up_2(%up,-2)
            else:
                %up_2_thin.visible = false
                %up_2_thick.visible = false
        if %right.is_colliding() :
            if check_loop_rotated(%right) == false and left_flag == false and right_flag == false:
                disable_shapecasts()
                #### To make the up and down lines invisible
                up_down_invisible()
                sides_invisible()
                expand_right(0)
        elif %right_2.is_colliding() :
            disable_shapecasts()
            #### To make the up and down lines invisible
            up_down_invisible()
            sides_invisible()
            expand_right(25)
        if %left.is_colliding():
          if check_loop_rotated(%left) == false and left_flag == false and right_flag == false:
            disable_shapecasts()
            if %left.is_colliding():
                up_down_invisible()
                sides_invisible()
                expand_left(10)
        elif %left_2.is_colliding():
            disable_shapecasts()
            up_down_invisible()
            sides_invisible()
            expand_left(25)
                #
        if %up_down_right.is_colliding():
            right_flag = true
            if check_loop_rotated(%up_down_right) == false:
                up_down_invisible()
                right_left_invisible()
                expand_up_down_right(20)
            elif check_loop_rotated(%up_down_right) == true:
                if %up_right.is_colliding():
                    sides_invisible()
                    right_left_invisible()
                    expand_up(%up_right, 10)
                if %down_right.is_colliding():
                    sides_invisible()
                    right_left_invisible()
                    expand_down(%down_right, 10)
        if %up_down_left.is_colliding():
            right_flag = false
            if check_loop_rotated(%up_down_left) == false:
                up_down_invisible()
                expand_up_down_left(20)
                
            elif check_loop_rotated(%up_down_left) == true:
                if %up_left.is_colliding():
                    sides_invisible()
                    right_left_invisible()
                    expand_up(%up_left, -16)
                if %down_left.is_colliding():
                    sides_invisible()
                    right_left_invisible()
                    expand_down(%down_left, -16)

####  To prevent if from constantly restarting 
## Timer starts when its touching a platfrosm
        if timer_flag == false:
          %Timer.start()
          timer_flag = true
func _on_timer_timeout() -> void:
    queue_free() 
func _on_body_entered(body: Node2D) -> void:

    if body.is_in_group("platforms") or body.is_in_group("blocks")  or body.is_in_group("ground"):
        touch_platform = true
        %electric_sfx.play()
        rotation = 0
        
    if body.is_in_group("blocks") :
        on_plat_block = true
        
## TODO: Gotta add the damage to player here
    elif body.is_in_group("player"):
        player_entered_trap = true
        return
        
func _on_body_exited(body: Node2D) -> void:
        if body.is_in_group("player"):
           player_entered_trap = false

#region for all the functions
################################################
func delete_self():
    if on_plat_block == true :
        if is_instance_valid(blocks) and  blocks.delete_electric == true:
            print("deleting self")
            queue_free()

func disable_shapecasts():
    for shape in %raycasts.get_children():
        shape.enabled = false
func up_down_invisible():
    %right_up_thin.visible = false
    %right_down_thin.visible = false
    %right_up_thick.visible = false
    %right_down_thick.visible = false
    %left_up_thin.visible = false
    %left_down_thin.visible = false
    %left_up_thick.visible = false
    %left_down_thick.visible = false
func right_left_invisible():
    
    %right_thin.visible = false
    %left_thin.visible = false
    %right_thick.visible = false
    %left_thick.visible = false
func sides_invisible():
    %right_side_thin.visible = false
    %right_side_thick.visible = false
    %left_side_thin.visible = false
    %left_side_thick.visible = false
###########################################################

func rotated_block():
    
    for cell in blocks.get_used_cells():
         if not blocks.is_cell_transposed(cell):
            dictionary[cell] = "not_rotated"
func rotated():
    
        for cell in platform.get_used_cells():
            
            if platform.is_cell_transposed(cell) :
                dictionary[cell] = "rotated"
            else:
                dictionary[cell] = "not_rotated"     
func check_pos(shape_cast):  
    var current_pos = shape_cast.get_collision_point(0)
    var local_pos = platform.to_local(current_pos)
    var tile_position : Vector2i = platform.local_to_map(local_pos)
    return tile_position
func check_array(shape_cast :ShapeCast2D): 
## This func takes the position of the current shapecast, localizes it, then turns it into tile grid coordinates
    var current_pos = shape_cast.get_collision_point(0)
    var local_pos = platform.to_local(current_pos)
    var tile_position : Vector2i = platform.local_to_map(local_pos)
    var tile_positions : Array = [Vector2i(tile_position.x,tile_position.y) ,Vector2i(tile_position.x,tile_position.y+1) , Vector2i(tile_position.x,tile_position.y-1),Vector2i(tile_position.x,tile_position.y),Vector2i(tile_position.x+1,tile_position.y),Vector2i(tile_position.x-1,tile_position.y),Vector2i(tile_position.x,tile_position.y),Vector2i(tile_position.x -2,tile_position.y)]
    return tile_positions
func check_loop_rotated(shape_cast:ShapeCast2D):
## This is due to inaccuracies in the detection of the non rotated tiles, i make them cycle through an array till a pos in dict is found
    for pos in (check_array(shape_cast)):
        if dictionary.get(pos)== "rotated":
## if a position with a small offset is found then it gives a flag that continues the expansion of the coll_shapes
            return  true
    return false
#######################################################################
#region for Expansion
func expand_up(up_down_direction: ShapeCast2D, offset: int):        
        %coll_right.shape.extents.y += spread
        %coll_right.position.y = -%coll_right.shape.extents.y 
        %coll_right.position.x = %up_right.position.x + offset
        %coll_left.position.x = %up_right.position.x + offset
        
        up_down_direction.position.y = -%coll_right.shape.extents.y *2            
func expand_down(up_down_direction : ShapeCast2D, offset: int):       
        %coll_left.shape.extents.y += spread
        %coll_left.position.y = %coll_left.shape.extents.y 
        %coll_left.position.x = %down_right.position.x + offset
        up_down_direction.position.y = %coll_left.shape.extents.y * 2             
func expand_right(offset):
        %coll_right.shape.extents.x += spread
        %coll_right.position.x = %coll_right.shape.extents.x
## This line is added to adjust the position of the collsion box for the offset of the electric lines
        %coll_right.position.y = %right.position.y + offset
        %right.position.x = %coll_right.shape.extents.x  *2 
func expand_left(offset):
            %coll_left.shape.extents.x += spread
            %coll_left.position.x = -%coll_left.shape.extents.x  
## This line is added to adjust the position of the collsion box for the offset of the electric lines
            %coll_left.position.y = %left.position.y + offset
            %left.position.x = -%coll_left.shape.extents.x *2  

func expand_up_down_right(offset):
        %coll_right.shape.extents.x += spread
        %coll_right.position.x = %coll_right.shape.extents.x
        %coll_right.position.y = %up_down_right.position.y + offset
        %up_down_right.position.x = %coll_right.shape.extents.x  *2 + 10  
    ## These lines are so the left collision box stays with the right   
    ## make this negative if u wanna explore the dual moving tiles
    
        %coll_left.position.x = %coll_right.position.x /2
        %coll_left.position.y = %coll_right.position.y 
func expand_up_down_left(offset):
        %coll_left.shape.extents.x += spread
        %coll_left.position.x = -%coll_left.shape.extents.x + offset
        %coll_left.position.y = %up_down_left.position.y + offset
        
        %up_down_left.position.x = -%coll_left.shape.extents.x  *2 - 10   
    ## These lines are so the right collision box stays with the left   
    ## make this negative if u wanna explore the dual moving tiles
        %coll_right.position.x = %coll_left.position.x /2
        %coll_right.position.y = %coll_right.position.y
    
func expand_up_2(up: ShapeCast2D, offset: int):
        %coll_right.shape.extents.y += spread
        %coll_right.position.y = -%coll_right.shape.extents.y 
        %coll_right.position.x = %up_right.position.x + offset
        %coll_left.position.x = %up_right.position.x + offset
        up.position.y = -%coll_right.shape.extents.y *2  
#endregion

func get_first_block():
    var block_list = get_tree().get_nodes_in_group("blocks")
    return block_list[0] if block_list.size() > 0 else null
# TODO: Fix the delay in glow problem for the block
func change_hue_pitch():
    
    G += .02
    modulate = Color(1 - G , 1 - G, 1 -G)  # Tint reddish

func _on_change_color_timeout() -> void:
    change_hue_pitch()

#endregion
func entered_trap():
    if player_entered_trap:

        player.get_node("Hurtbox").take_damage(damage, Vector2(10,0), %Sprite2D)
