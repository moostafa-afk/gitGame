extends Line2D
var timer : float = 0
@export var time_finished :float = .02
var reset : bool = true
@onready var extents :=0
@export var Low_Y := 10
@export var High_Y := -10
@export var offset :int = 0
var increase :=2
@export var max_increase :=10

var end_point := Vector2.ZERO
var point: Vector2 = Vector2.ZERO
var y_pos :int= 0 
var x_pos :int= 0

## To prevent overwriting the old points
var point_2: Vector2 = Vector2.ZERO
var y_pos_2 := 0 
var x_pos_2 := 0


func _physics_process(delta: float) -> void:
    ## Y coordinate radomness here
    timer += delta
    if timer >= time_finished:
        timer = 0.0
        for i in points.size():
            var point = points[i]
            point.y = randi_range(Low_Y,  High_Y)
            points[i] = point


func _on_area_coll_left(extent_left: Vector2) -> void:
## Point logic here

    
    if int(extent_left.x) % 2 == 0:
## No need for the negative here its already addded since extent_left is assigned to %left.position
        x_pos = (extent_left.x + offset) 
        y_pos = extent_left.y
        point = Vector2(x_pos, y_pos)        



        if is_duplicate(point) == false:
          add_point(point) 
        
        if is_duplicate(point) == true:
          offset_left()
        


func offset_left() :           
        if increase <= max_increase:
## I can change this if i want to modify the frequency 
            increase += 2
            x_pos_2 = (end_point.x + offset) - increase
            y_pos_2 = %coll_shape.shape.extents.y
            point_2 = Vector2(x_pos_2, y_pos_2)
            
            if is_duplicate(point_2) == false:
                add_point(point_2)


func is_duplicate(new_point: Vector2) -> bool:
    for i in range(points.size()):
        if new_point == points[i]:
            end_point = points[i]
            return true
    return false
    
    
    
