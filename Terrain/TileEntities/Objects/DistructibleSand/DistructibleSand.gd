extends InteractableTerrain

func _ready():
	$Hitbox.layer = layer

func _on_Hitbox_area_entered(area):
	if area.has_meta('player_explosion'):
		queue_free()
