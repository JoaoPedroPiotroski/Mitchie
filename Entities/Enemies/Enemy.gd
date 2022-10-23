extends Entity
class_name Enemy

export var gold_max = 1
export var gold_min = 1

onready var golden_shower = preload("res://Items/GoldenShower.tscn")

func _die():
	var gs = golden_shower.instance()
	get_parent().add_child(gs) 
	gs.start(gold_min, gold_max, global_position)
	queue_free()

func _ready():
	add_to_group("enemies")
