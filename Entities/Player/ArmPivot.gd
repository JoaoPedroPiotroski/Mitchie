extends Node2D

onready var directions = get_parent().get_node("Directions")

func _physics_process(_delta):
	if !get_parent().state_machine.current_state in [
		"Attack", "Attack2", "Pull", "Pull2"
	]:
		if directions.get_input_direction() in [Vector2.RIGHT, Vector2.LEFT]:
			look_at(global_position + (directions.get_input_direction()))
		if directions.get_input_direction() == Vector2.LEFT:
			$Scythe/base_attack_effect.rotation_degrees = PI
			$Scythe/base_attack_effect.flip_v = true
		else:
			$Scythe/base_attack_effect.rotation_degrees = 0
			$Scythe/base_attack_effect.flip_v = false
	if get_parent().state_machine.current_state == "Attack2":
		pass
			
