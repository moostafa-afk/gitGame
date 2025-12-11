@tool
extends EditorScript
## 14 , 20 , 23, 51
## 14 is for the name of the parent node
## 20 is for the location of the sprite
## 23 is for the number of sprite frames
## 51 is for the beginning of name of each node

## Called when the script is executed (using File -> Run in Script Editor).
func _run():
    ## Create new node to store as output
    var output_node : Node2D = Node2D.new()
## Change the name of the parent node here
    output_node.name = "collsion" # CHANGE THIS if needed
    get_scene().add_child(output_node)
    output_node.owner = get_scene()
    

## Paht location is here
    var sprite_image : Image = get_scene().get_node(".").texture.get_image() # CHANGE PATH if needed
    
## Nubmer of frames here
    var frames = 3
    var frame_width = sprite_image.get_width() / frames
    
    var image_bitmap : BitMap = BitMap.new()
    image_bitmap.create_from_image_alpha(sprite_image)
    
    var hb_points = image_bitmap.opaque_to_polygons(Rect2(Vector2(), image_bitmap.get_size()), 0.01)

    var frame_polygons := {}

    for arr in hb_points:
        var current_frame = floor(arr[0].x / frame_width)

        for i in range(arr.size()):
            arr[i].x -= current_frame * frame_width

        if not frame_polygons.has(current_frame):
            frame_polygons[current_frame] = []
        frame_polygons[current_frame].append(arr)

    var sorted_frames = frame_polygons.keys()
    sorted_frames.sort()

    for frame in sorted_frames:
        for i in range(frame_polygons[frame].size()):
            var tmp_poly : CollisionPolygon2D = CollisionPolygon2D.new()
            
## Change the children beginning names here is the quotaitions poly.name
            tmp_poly.name = "laser %d_%d" % [frame, i] # Change "walk" if needed
            tmp_poly.polygon = frame_polygons[frame][i]
            tmp_poly.disabled = true
            output_node.add_child(tmp_poly)
            tmp_poly.owner = get_scene()
