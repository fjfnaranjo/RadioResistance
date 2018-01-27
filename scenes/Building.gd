extends StaticBody2D

export var loyalty = 5
var still_loyal = true

var broadcasting = false

const CAPTURED_BUILDING_ALERT = 0

func _ready():
	set_process(true)
	add_to_group("buildings")
	get_node("Loyalty").set_text(str(loyalty))
	State.active_scene.add_victory_points()

func _process(delta):
	pass

func hurt():
	if (loyalty > 0):
		loyalty -= 1
		get_node("Loyalty").set_text(str(loyalty))
	elif(still_loyal):
		_capture_building()

func _capture_building():
	get_node("Loyalty").set_text(":)")
	State.play_sample("building_converted") 
	if (State.active_scene.has_method("reduce_victory_points")):
		State.active_scene.reduce_victory_points()
	if(State.active_scene.has_method("increase_alert")):
		State.active_scene.increase_alert(CAPTURED_BUILDING_ALERT)

	still_loyal = false
