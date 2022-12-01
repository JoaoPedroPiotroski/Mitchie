extends Entity
class_name Enemy

export var gold_max : int = 1
export var gold_min : int = 1

export var spawn_gold : bool = false

onready var golden_shower_scene = preload("res://Items/GoldenShower.tscn")

func golden_shower():
	var gs = golden_shower_scene.instance()
	get_parent().add_child(gs) 
	gs.start(gold_min, gold_max, global_position)


func _die():
	if spawn_gold:
		golden_shower()
	queue_free()

func _ready():
	add_to_group("enemies")
