extends StaticBody2D
class_name InteractableTerrain

export(int, "Layer1", "Layer2") var layer setget set_layer
export var collides_with_player = false

# emitido toda vez que set_layer() é chamado
signal layer_changed

func _ready():
	add_to_group("pseudo-entities")
	set_layer(layer)
	
func switch_layer() -> void: # troca entre as duas camadas
	if layer == 0:
		set_layer(1)
	else:
		set_layer(0)
	

func set_layer(new_layer) -> void: # estabelece uma camada deterministica
	set_collision_mask_bit(layer, false)
	set_collision_mask_bit(new_layer, true)
	if collides_with_player:
		set_collision_layer_bit(layer, false)
		set_collision_layer_bit(new_layer, true)
	layer = new_layer
	emit_signal("layer_changed")
	
	
	if layer == 0:
		z_index = 0
	else:
		z_index = -2
	
func go_to_layer(new_layer):
	set_layer(new_layer)

func get_opposite_layer():
	if layer == 0:
		return 1
	return 0
