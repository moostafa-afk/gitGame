extends Node2D
var angle_cone_of_vision := deg_to_rad(30)
var max_view_distance :=1000
var angle_between_rays := deg_to_rad(5)
var target : CharacterBody2D
func generate_raycasts() -> void:
    
    var ray_count : int = angle_cone_of_vision / angle_between_rays
    for index in ray_count:
        var ray := RayCast2D.new()
        #var angle := angle_between_rays * (index - ray_count /2)
        #ray.cast_to = Vector2.UP.rotated(angle) * max_view_distance
        add_child(ray)
        ray.enabled = true
        
func _physics_process(delta: float) -> void:
    generate_raycasts()
    for ray in get_children():
        if ray.is_colliding() and ray.get_collider() is Player:
            target = ray.get_collider()
            break
    var does_see_player := target != null
