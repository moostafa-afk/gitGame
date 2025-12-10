extends Line2D

@onready var extents: int = %coll_shape.shape.extents.x
var timer: float = 0.0
@export var time_finished: float = 0.1

var y_pos := 0 
var x_pos := 0
var neg_x_pos := 0
var left_x_pos := 0

func _physics_process(delta: float) -> void:
    timer += delta
    if timer >= time_finished:
        timer = 0.0  # reset timer

        # Randomize point Y positions
        for i in points.size():
            var point = points[i]
            point.y = randf_range(-10, 10)
            points[i] = point


        # Add new point only if extents is a multiple of 3
        if extents % 3 == 0:
            neg_x_pos = -extents + 14
            y_pos = %coll_shape.shape.extents.y

            add_point(Vector2(neg_x_pos,y_pos))
func _on_area_coll_left(extent_x: int) -> void:
    if  extent_x % 2 == 0 :
        neg_x_pos  = extent_x 
        y_pos = %coll_shape.shape.extents.y
        add_point(Vector2(neg_x_pos, y_pos))
        
#func _on_area_area_spread(spread: int) -> void:
    #spread /= 2
    #extents = %coll_shape.shape.extents.x - spread
