extends CPUParticles2D

func start(pos):
	global_position = pos

func _ready() -> void:
	emitting = true
