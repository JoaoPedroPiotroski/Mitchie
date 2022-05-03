extends Node
class_name StateMachine

export (String, MULTILINE) var _initial_states: String = ""
export(int) var default_state = 0

var states = {
	
}
var current_state : int

func _ready():
	var temp = _initial_states.split('\n')
	var idx = 0
	for value in temp:
		states[value] = idx
		idx += 1
	current_state = 0
	
func change_state(new_state: String):
	current_state = states[new_state]

func get_number_from(state: String):
	return states[state]

func get_state():
	return current_state
