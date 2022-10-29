extends InteractableTerrain

onready var golden_shower_scene = preload("res://Items/GoldenShower.tscn")

func golden_shower():
	var gs = golden_shower_scene.instance()
	get_parent().add_child(gs) 
	gs.start(1, 5, global_position)
	

func die():
	queue_free()

func _on_Hitbox2_area_entered(area):
	if area.has_meta('player_attack1'):
		AudioManager.play_fx("res://Entities/Player/attacks/sword_clash.9.ogg")
		$AnimationPlayer.play('break')
