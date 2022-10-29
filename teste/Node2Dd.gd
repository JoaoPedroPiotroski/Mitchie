extends Node2D

export(Array, PackedScene) var droplist
	

func _ready():
	var itemdrop = load("res://Items/Drop/ItemDrop.tscn")
	var test_item = itemdrop.instance()
	test_item.setup(Global.random_from_array(droplist), 0)
	add_child(test_item)
