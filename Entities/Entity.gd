extends KinematicBody2D

class_name Entity

# a qual das duas camadas a entidade pertence
export(int, "Layer1", "Layer2") var layer setget set_layer
export(int) var health = 1
export var collides_with_player = false
export var immortal = false
export var override_scale = false
export var override_modulate = false
export var override_knockback = false

var tween

# emitido toda vez que set_layer() é chamado
signal layer_changed

func _ready():
	add_to_group("entities")
	connect("layer_changed", self, 'update_layer_scale')
	connect("layer_changed", self, 'update_layer_modulate')
	tween = Tween.new() 
	add_child(tween)
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
	
func update_health():
	if health <= 0 and !immortal: 
		_die()
	
func apply_damage(damage):
	health -= damage
	update_health()

func _die():
	queue_free()
	
func update_layer_scale():
	if override_scale:
		return
	var val
	if layer == 1:
		val = 0.85
	elif layer == 0:
		val = 1
	tween.interpolate_method(self, 'set_scale_based_on_layer', scale.x, val, .2)
	tween.start()
	
func update_layer_modulate():
	if override_modulate:
		return
	var col
	if layer == 1:
		col = Color('d4c9da')
	if layer == 0:
		col = Color(1, 1, 1, 1)
	tween.interpolate_property(self, 'modulate', modulate, col, .2)
	tween.start()
	
func set_scale_based_on_layer(val):
	set_deferred('scale', Vector2(val, val))
	
func _knockback(force, dir):
	tween.remove_all()
	if override_knockback:
		return
	tween.interpolate_property(self, 'global_position', global_position, global_position + (force * dir), .2)
	tween.start()
	
