extends Control

onready var health = $Health
onready var max_health = $Health/MaxHealth
onready var mana = $Mana
onready var max_mana = $Mana/MaxMana
onready var collection_display = $DisplayItemCollected

var display_timers = []

func _ready():
	var _c = Global.connect("player_updated", self, 'update_vis')
	yield(get_tree().create_timer(0.1), 'timeout')
	_c = Inventory.connect("item_added", self, 'update_collection_display')
	update_vis()
	
func update_vis():
	if weakref(Global.player).get_ref() and SceneManager.level.type != "Menu":
		visible = true
		update_sliders()
		if !Global.player.get_node('Stats/Current').is_connected("health_update", self, 'update_sliders'):
			var _c = Global.player.get_node('Stats/Current').connect("health_update", self, 'update_sliders')
			_c = Global.player.get_node('Stats/Current').connect("mana_update", self, 'update_sliders')
	else:
		visible = false
		
func update_sliders():
	if weakref(Global.player).get_ref():
		health.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').health, 18
		)
		max_health.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').max_health,18
		)
		mana.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').mana,18
		)
		max_mana.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').max_mana,18
		)

func update_collection_display(title, amount):
	var _c = get_tree().create_timer(3, true).connect('timeout', self, '_on_Timer_delete_collection')
	var disp_title = title.capitalize()
	if Inventory.get_item(title).stackable:
		collection_display.text += disp_title + " x" + String(amount) + "\n"
	else:
		collection_display.text += disp_title + "\n"

func _on_Timer_delete_collection() -> void:
#	display_timers.remove(0)
	var next_delete = collection_display.text.find('\n')
	collection_display.text = collection_display.text.substr(next_delete+1, -1)
	if next_delete == 0:
		collection_display.text = ''
