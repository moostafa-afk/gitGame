extends Node
@onready var player := get_tree().get_nodes_in_group("player")[0]

func _ready() -> void:
    player.connect("add_block",on_add_block)
    

func on_add_block():
   print("added block")
   var load_block = preload("res://scenes/block/block.tscn")
   var inst = load_block.instantiate()
   add_child(inst)

### Add the instances to the list
   #block_list.append(inst)
###Checks if the list is more than exported number
   #if block_list.size() > block_num:
###If it is it removes the oldest one from the list
    #var old = block_list.pop_front()
### If the oldest hasnt timer out it deletes it 
    #if is_instance_valid(old): old.queue_free()

   inst.global_position.x = player.global_position.x
   inst.global_position.y = player.global_position.y + 30
   
