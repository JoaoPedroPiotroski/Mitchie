extends Control

func _ready():
	Engine.target_fps = 60

func _process(delta):
	$Fps.text = String(Engine.get_frames_per_second())
