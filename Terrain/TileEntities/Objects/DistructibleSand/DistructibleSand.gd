extends InteractableTerrain

func _on_Hitbox_area_entered(area):
	if area.has_meta('player_explosion'):
		$AnimationPlayer.play('die')
		$CollisionShape2D.set_deferred('disabled', true)
		$Hitbox/CollisionShape2D2.set_deferred('disabled', true)
		AudioManager.play_fx("res://Terrain/TileEntities/Audio/tile_break.wav")
