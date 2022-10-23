extends Control

onready var health = $Health
onready var max_health = $Health/MaxHealth
onready var mana = $Mana
onready var max_mana = $Mana/MaxMana

func _ready():
	var _c = Global.connect("player_updated", self, 'update_vis')
	yield(get_tree().create_timer(0.1), 'timeout')
	update_vis()
	
func update_vis():
	if Global.player != null:
		visible = true
		update_sliders()
		if !Global.player.get_node('Stats/Current').is_connected("health_update", self, 'update_sliders'):
			var _c = Global.player.get_node('Stats/Current').connect("health_update", self, 'update_sliders')
			_c = Global.player.get_node('Stats/Current').connect("mana_update", self, 'update_sliders')
	else:
		visible = false
		
func update_sliders():
	health.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').health, 18
	)
	max_health.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').max_health,18
	)
	mana.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').mana,18
	)
	max_mana.rect_size = Vector2(22 * Global.player.get_node('Stats/Current').max_mana,18
	)
