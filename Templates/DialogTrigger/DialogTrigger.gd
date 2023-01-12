extends PseudoEntity
class_name DialogTrigger

export(String) var timeline
export(Array, String) var requisites
export(Array, String) var item_requisites
export(Array, String) var deletabilities
export(Array, String) var item_deletabilities
export(bool) var autoplay = false

func _ready():
	add_to_group('requisite_needs')
	update_needs()
	
func disable_collisions() -> void:
	visible = false
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred('disabled', true)

func enable_collisions() -> void:
	visible = true
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred('disabled', false)
	
func update_needs():
	var problems = false
	for r in requisites:
		if !Save.progress_flags.has(r):
			print('me deletei')
			problems = true
	for d in deletabilities:
		if Save.progress_flags.has(d):			
			print('me deletei' + timeline)
			problems = true
	for r in item_requisites:
		if not Inventory.has_item(r):			
			print('me deletei')
			problems = true
	for d in item_deletabilities:
		if Inventory.has_item(d):
			print('me deletei' + timeline)
			problems = true
	if problems:
		disable_collisions()
	else:
		enable_collisions()
	set_collision_layer_bit(0, false)
	set_collision_layer_bit(4, true)
	set_collision_mask_bit(0, false)
	hide_hint()

func show_hint():
	if has_node('door_hint'):
		get_node('door_hint').visible = true
	
func hide_hint():
	if has_node('door_hint'):
		get_node('door_hint').visible = false
