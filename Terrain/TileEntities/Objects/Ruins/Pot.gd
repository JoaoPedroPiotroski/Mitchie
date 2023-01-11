extends InteractableTerrain

onready var golden_shower_scene = preload("res://Items/GoldenShower.tscn")

var potion_chance = 5

func golden_shower():
	if rand_range(0, 100) < potion_chance:
		Inventory.add_item_by_title('health_pot', 1)
	else:
		var gs = golden_shower_scene.instance()
		get_parent().add_child(gs) 
		gs.start(1, 5, global_position)
		

func die():
	queue_free()

func _on_Hitbox2_area_entered(area):
	if area.has_meta('player_attack'):
		AudioManager.play_fx("res://Entities/Player/attacks/sword_clash.9.ogg")
		$AnimationPlayer.play('break')
