extends Area2D
class_name PseudoEntity

export var collides_with_player = false

func _ready():
	add_to_group("pseudo-entities")
