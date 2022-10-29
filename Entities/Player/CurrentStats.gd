extends Node

signal health_update
signal mana_update

var max_health setget set_max_health
var max_mana setget set_max_mana
var health setget set_health
var mana setget set_mana
var max_speed
var terminal_velocity 
var gravity 
var falling_gravity_modifier
var acceleration
var friction  
var air_acceleration_modifier
var air_friction_modifier 
var stopping_friction_modifier 
var jump_force

func set_max_health(new_value):
	max_health = new_value
	emit_signal("health_update")

func set_max_mana(new_value):
	max_mana = new_value
	emit_signal("mana_update")

func set_health(new_value):
	health = new_value
	Global.current_player_health = health
	emit_signal("health_update")

func set_mana(new_value):
	mana = max(0, new_value)
	mana = min(mana, max_mana)
	Global.current_player_mana = mana
	emit_signal("mana_update")
