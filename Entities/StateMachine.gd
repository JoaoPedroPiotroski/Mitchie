extends Node
class_name StateMachine

export (String, MULTILINE) var _initial_states: String = ""
export(String) var default_state = ""

var states = {
	
}
var current_state : String setget set_state, get_state
var previous_state

func _ready():
	var temp = _initial_states.split('\n')
	var idx = 0
	for value in temp:
		states[value] = idx
		idx += 1
	current_state = default_state
	
func change_state(new_state: String):
	current_state = new_state

func get_number_from(state: String):
	return states[state]
	
func get_state():
	return current_state
	
func set_state(new_state):
	previous_state = current_state
	current_state = new_state
