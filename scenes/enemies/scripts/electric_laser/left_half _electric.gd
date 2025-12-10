extends Line2D

@onready var extents : Vector2 = %coll_shape.shape.extents

var timer :float =0  
@export var time_finished: float = 0.1
@export var Low_Y := 10
@export var High_Y := -10

@export var offset :int = 0
var increase :=0
@export var max_increase :=10

var end_reached := false
var end_point :int = 0
var point: Vector2 = Vector2.ZERO
var y_pos := 0 
var x_pos := 0

## To prevent overwriting the old points
var point_2: Vector2 = Vector2.ZERO
var y_pos_2 := 0 
var x_pos_2 := 0
func _physics_process(delta: float) -> void:
    
        ## Y coordinate radomness here

    timer += delta
    if timer >= time_finished:
        timer = 0.0  # reset timer

        # Randomize point Y positions
        for i in points.size():
            var point = points[i]
            point.y = randi_range(Low_Y,  High_Y)
            points[i] = point
       
    ## Point logic here
     


func _on_area_area_spread(spread: int) -> void:
    extents = %coll_shape.shape.extents
    
    extents.x -= spread 
    ## Point logic
    if int(extents.x) % 2 == 0:
        x_pos = (-extents.x + offset) 
        y_pos = extents.y
        point = Vector2(x_pos, y_pos)
        #
        if is_duplicate(point) == false:
          add_point(point) 
        
        elif is_duplicate(point) == true:
            offset_left()         

func offset_left() :           
    
        if increase <= max_increase:
## I can change this if i want to modify the frequency 
            increase += 2
            
            x_pos_2 = (end_point + offset) - increase
            y_pos_2 = extents.y
            point_2 = Vector2(x_pos_2, y_pos_2)
            if is_duplicate(point_2) == false:
                add_point(point_2)


func is_duplicate(new_point: Vector2) -> bool:
    for i in range(points.size()):
        if new_point.x == points[i].x:
            end_point = points[i].x
            return true
    return false
