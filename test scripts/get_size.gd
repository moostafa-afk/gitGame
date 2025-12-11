extends Node

func _ready():
    var size = %Sprite2D.texture.get_size() * %Sprite2D.scale
    print(size)
