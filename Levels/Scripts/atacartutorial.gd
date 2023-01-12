extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func _ready() -> void:
	if Save.progress_flags.has('attacktutorialseen'):
		queue_free()
	Save.add_progress_flag('attacktutorialseen')
