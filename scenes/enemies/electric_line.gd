extends Line2D
var timer : float = 0
@export var time_finished :float = .02
var reset : bool = true
@onready var extents :=0
@export var range := Vector2.ZERO

var y_pos := 0 
var x_pos := 0
var neg_x_pos := 0

var left_x_pos := 0 
var right_x_pos := 0


func _physics_process(delta: float) -> void:
    timer += delta
    if timer >= time_finished:
        timer = 0.0
        for i in points.size():
            var point = points[i]
            point.y = randi_range(Low_Y,  High_Y)
            points[i] = point
    
    
## Only add point if extents is divisible by 3
    if extents % 3 == 0 :
        x_pos  = %coll_shape.shape.extents.x  - 14
        y_pos = %coll_shape.shape.extents.y
        
        add_point(Vector2(x_pos,y_pos))




func _on_area_coll_right(extent_x: int) -> void:
    if  extent_x % 2 == 0 :
        right_x_pos  = extent_x  
        y_pos = %coll_shape.shape.extents.y
        add_point(Vector2(right_x_pos, y_pos))
        

        
func _on_area_area_spread(spread: int) -> void:
    extents = %coll_shape.shape.extents.x 
    spread /=2
    extents -= spread








## Im thinking of making a variable that would chekc on the extetnes.x, DONE
## Now i have to make an if statemnt to check if extents.x is a multiple of 30
## If it is, Ill add a point to that location how woulj

            

        
        
        
## So essentially if I want to change something just assign it to a var, tweak it, the reassign it to a var
## Basically its a complicated way of doing point[i] = points[i]
## to memorize            var =   points[i]
##                        ponts[i] =  var
          
