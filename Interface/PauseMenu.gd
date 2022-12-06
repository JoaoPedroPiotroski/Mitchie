extends Control

onready var item_detailer = $ItemDetail/Panel

signal game_pause_changed

func _input(event):
	if SceneManager.level.type == "Menu" or get_parent().get_node("CanvasLayer/Debug").working:
		return
	if event.is_action_pressed("pause") and Global.player.state_machine.current_state != "Dialog":
		emit_signal("game_pause_changed")
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused

func show_item_detail(item):
	item_detailer.get_node("Icon").texture = item.icon
	item_detailer.get_node("Title").text = item.title
	item_detailer.get_node("Desc").text = item.description
	item_detailer.get_parent().popup()
