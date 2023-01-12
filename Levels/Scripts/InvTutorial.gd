extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Save.progress_flags.has('inv_tutorial_seen'):
		queue_free()
	Save.add_progress_flag('inv_tutorial_seen')
