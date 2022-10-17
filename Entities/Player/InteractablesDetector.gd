extends Area2D

onready var player = get_parent()

func _on_InteractablesDetector_area_entered(area):
	if area is PseudoEntity:
		if area is DialogTrigger:
			player.current_dialog = Dialogic.start(area.timeline)
	if area is Area2D:
		if area.is_in_group('doors'):
			player.current_door = area
			if area.type == 'entrance':
				SceneManager.entrance = area.destination_entrance
				SceneManager.change_level(area.destination_level)
			area.show_hint()

func _on_InteractablesDetector_area_exited(area):
	if area is PseudoEntity:
		if area is DialogTrigger:
			player.current_dialog = null
	if area is Area2D:
		if area.is_in_group('doors'):
			player.current_door = null
			area.hide_hint()

func _on_InteractablesDetector_body_entered(body):
	if body is Entity:
		if body is ItemDrop:
			player.item_hover = body


func _on_InteractablesDetector_body_exited(body):
	if body is Entity:
		if body is ItemDrop:
			player.item_hover = null
