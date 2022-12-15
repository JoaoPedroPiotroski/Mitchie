extends Panel

var item : Resource

signal clicked(item)


func start(in_item : Resource):
	$TextureButton.texture_normal = in_item.icon
	item = in_item
	
# provavelmente abandonada para sempre
#func _ready(): 
#	return
#	var _c = connect("clicked", Menu.get_node("PauseMenu"), "show_item_detail", [item])
func _input(_event: InputEvent) -> void:
	if has_focus() and Input.is_action_just_pressed("jump"):
		_on_TextureButton_pressed()

func _on_TextureButton_pressed():
	emit_signal("clicked")
	if item.title == 'health_pot':
		if weakref(Global.player).get_ref():
			Global.player.current.health += 1
			Inventory.remove_item(item, 1)
			get_parent().visible = false
			get_parent().visible = true
			


func _on_ItemSlot_focus_entered() -> void:
	self_modulate = Color(0,0,0,0.4)


func _on_ItemSlot_focus_exited() -> void:
	self_modulate = Color(0,0,0,0)
