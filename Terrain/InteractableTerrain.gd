extends StaticBody2D
class_name InteractableTerrain

export var collides_with_player = false


func _ready():
	add_to_group("tile_entities")
