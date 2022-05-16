extends Area2D

onready var player = get_parent()

func _on_InteractablesDetector_area_entered(area):
	if area is PseudoEntity:
		if area is DialogTrigger:
			if area.layer == player.layer:
				player.current_dialog = Dialogic.start(area.timeline)
		if area is ItemDrop:
			if area.layer == player.layer:
				player.item_hover = area


func _on_InteractablesDetector_area_exited(area):
	if area is PseudoEntity:
		if area is DialogTrigger:
			player.current_dialog = null
		if area is ItemDrop:
			player.item_hover = null
