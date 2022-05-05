extends StateMachine

export (String, MULTILINE) var _secondary_states: String = ""
export(String) var default_secondary_state = ""

var secondary = {
	
}
var secondary_state = ""

func _ready():
	var temp = _secondary_states.split('\n')
	var idx = 0
	for value in temp:
		secondary[value] = idx
		idx += 1
	secondary_state = default_secondary_state
	
func change_secondary_state(new_state: String):
	secondary_state = secondary[new_state]

func get_number_from_secondary(state: String):
	return secondary[state]

func get_secondary():
	return secondary_state
