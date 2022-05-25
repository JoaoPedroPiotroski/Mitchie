extends Area2D

onready var player = get_parent()

func _on_InteractablesDetector_area_entered(area):
	if area is PseudoEntity:
		if area is DialogTrigger:
			if area.layer == player.layer:
				player.current_dialog = Dialogic.start(area.timeline)
	


func _on_InteractablesDetector_area_exited(area):
	if area is PseudoEntity:
		if area is DialogTrigger:
			player.current_dialog = null
		

func _on_InteractablesDetector_body_entered(body):
	if body is Entity:
		if body is ItemDrop:
			if body.layer == body.layer:
				player.item_hover = body


func _on_InteractablesDetector_body_exited(body):
	if body is Entity:
		if body is ItemDrop:
			player.item_hover = null
