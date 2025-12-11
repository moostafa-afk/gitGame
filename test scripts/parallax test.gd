extends ParallaxBackground

@export var camera_node_path: NodePath
var camera: Camera2D

func _ready():
    camera = get_node(camera_node_path)
    # Make sure the ParallaxBackground knows the camera's position
  

func _process(delta):
    if camera:
        # Optional: manually update the scroll offset
        # This is usually handled automatically if `follow_camera` is true
        scroll_offset = camera.get_screen_center_position()
