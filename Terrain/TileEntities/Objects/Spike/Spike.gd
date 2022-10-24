extends InteractableTerrain


func _on_DisableTimer_timeout():
	$Hitbox/CollisionShape2D.set_deferred('disabled', !$Hitbox/CollisionShape2D.disabled)
	$Hitbox2/CollisionShape2D.set_deferred('disabled', !$Hitbox2/CollisionShape2D.disabled)
