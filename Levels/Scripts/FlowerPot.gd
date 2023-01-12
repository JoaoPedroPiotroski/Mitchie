extends Sprite


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Save.progress_flags.has('flor_entregue'):
		visible = false
	add_to_group('requisite_needs')	

func update_needs():
	if not Save.progress_flags.has('flor_entregue'):
		visible = false
	else:
		visible = true
	
