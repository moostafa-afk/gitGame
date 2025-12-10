extends Node2D
var target : Player = null
var angle_cone_of_vision := deg_to_rad(120)
var max_view_distance :=1000
var angle_between_rays := deg_to_rad(5)

func _physics_process(delta: float) -> void:
    var cast_count := int(angle_cone_of_vision/ angle_between_rays) + 1
    for index in cast_count:
        var cast_vector  := (
        max_view_distance * Vector2.UP.rotated((angle_between_rays) * index - (cast_count/2))
        )
        %RayCast2D.target_position = cast_vector
        %RayCast2D.force_raycast_update()
        precalculate_ray_coordinates()
        
        if %RayCast2D.is_colliding() and %RayCast2D.get_collider() is Player:
            target = %RayCast2D.get_collider()
            
        
func precalculate_ray_coordinates() -> Array:
    var cast_vectors := []
    var cast_count := int(angle_cone_of_vision / angle_between_rays) + 1
    for index in cast_count:
        var cast_vector:= (
            max_view_distance * Vector2.UP.rotated(angle_between_rays * (index - cast_count /2.0))
        )
        cast_vectors.append(cast_vector)
    return cast_vectors
