extends Line2D

var time : float = 0.0
@export var end_time:= .02
@export var Low : =-15
@export var High : =15

var x_pos :=0
var y_pos :=0
var point := Vector2.ZERO
var point_2 := Vector2.ZERO
@export var offset_x := 0
@export var offset_y := 0

@export var max_increase := 10
var just_collided : = false
var normal_increase := 0
var increase:= 0

func _physics_process(delta: float) -> void:
    #
    time += delta
    if time >= end_time:
        time = 0
        for i in points.size():
            point = points[i]
            point.y = randi_range(Low+ offset_y, High + offset_y)
            points[i] = point
            
## (Plus + normal increase) to constantly add points to the right_2
    point = Vector2((x_pos + normal_increase ), y_pos )
## Pointis outside the if statemnts cuz its an argument that constantly needs to be checked for duplicates
    if %right_2.is_colliding():
## Just_collided is a flag that will deterine its first location, increase will add the rest  of the points
        if just_collided == false:
           x_pos = (%right_2.position.x - offset_x)
           y_pos = (%right_2.position.y + offset_y)
           just_collided = true
## Increase starts here
        elif is_duplicate(point) == false:
            normal_increase += 2
            add_point(point)
            
## this will decide the max_increase
    elif not %right_2.is_colliding() and just_collided == true:
            max_point()
    
func max_point():
    
    if increase <= max_increase:
        increase += 2
        point_2 = Vector2(point.x + increase, point.y)
        add_point(point_2)

   
func is_duplicate(new_point: Vector2) -> bool:
    for i in range(points.size()):
        if new_point == points[i]:
            return true
    return false
    
    
    
    
    
