extends KinematicBody2D

class_name Entity

export(int, "Layer1", "Layer2") var layer setget set_layer

signal layer_changed

func _ready():
	add_to_group("entities")
	
func _switch_layer():
	print(layer)
	if layer == 0:
		set_layer(1)
	else:
		set_layer(0)
	
func set_layer(new_layer):
	set_collision_mask_bit(layer, false)
	
	set_collision_mask_bit(new_layer, true)
	layer = new_layer
	emit_signal("layer_changed")
	
	
	if layer == 0:
		z_index = 0
	else:
		z_index = -2
	
func _go_to_layer(new_layer):
	set_layer(new_layer)
