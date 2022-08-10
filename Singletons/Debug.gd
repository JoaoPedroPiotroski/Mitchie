extends Control

var working = false

func _ready():
	Engine.target_fps = 60

func _process(_delta):
	$Fps.text = String(Engine.get_frames_per_second())
