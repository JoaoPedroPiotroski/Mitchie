extends Label

func _ready() -> void:
	if Save.progress_flags.has('jumptutorialseen'):
		queue_free()
	Save.add_progress_flag('jumptutorialseen')
