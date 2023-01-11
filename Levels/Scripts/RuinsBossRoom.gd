extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var player_pos : Vector2
onready var player = $Player
var fog_density = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_song("res://Music/Audio/BossRoomIntro.wav", 0, false)

func _process(_delta: float) -> void:
	player_pos = player.global_position
	var fog_pre_value = player.global_position.x + 237
	var fog_normalized = abs(fog_pre_value) / (880 - 237)
	if player_pos.x > -237:
		fog_normalized = 0
	print(fog_normalized)
	$CanvasLayer2/fog.modulate.a = fog_normalized
