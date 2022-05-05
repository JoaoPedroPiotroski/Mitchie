extends Node

export(int) var max_health = 3
export(int) var max_mana = 10
export(int) var health = 3 
export(int) var mana = 10 
export(float) var max_speed = 250 
export(float) var acceleration = 1000 
export(float) var terminal_velocity = 600 
export(float) var gravity = 2000
export(float) var friction = 4
export(float) var air_acceleration_modifier = 0.8
export(float) var air_friction_modifier = 0.5
export(float) var stopping_friction_modifier = 4

var additional_health = 0 setget set_additional_health, get_additional_health
var additional_mana = 0  setget set_additional_mana, get_additional_mana

onready var current = $Current
onready var player = get_parent()

func _ready():
	update_current_stats()

func update_current_stats():
	current.max_health = max_health + additional_health
	current.max_mana = max_mana + additional_mana
	current.health = health
	current.mana = mana + additional_mana
	current.max_speed = max_speed
	current.acceleration = acceleration
	current.terminal_velocity = terminal_velocity
	current.gravity = gravity
	current.friction = friction
	current.air_acceleration_modifier = air_acceleration_modifier
	current.air_friction_modifier = air_friction_modifier
	current.stopping_friction_modifier = stopping_friction_modifier

func set_additional_health(amount):
	additional_health = amount
	
func get_additional_health():
	return additional_health

func set_additional_mana(amount):
	mana = amount
	
func get_additional_mana():
	return additional_mana
	
func damage(amount):
	current.health -= amount 
	if current.health <= 0:
		player._die()
