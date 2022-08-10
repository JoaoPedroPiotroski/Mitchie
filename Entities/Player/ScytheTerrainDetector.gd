extends PseudoEntity

onready var player = get_parent().get_parent().get_parent()
onready var directions = get_parent().get_parent().get_parent().get_node("Directions")

func _on_TerrainDetector_body_entered(_body):
	player._knockback(80, -directions.get_input_direction())
