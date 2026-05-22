##Class for base condition components
##change the variable response when you want it to be changed to that state
class_name ConditionComponent
extends Node

var manager : StateManager
@export var i_time : float = 0.25
var timer : float = i_time
var timer_on : bool = true
var changeable : bool = false
var response : String = ""

func _ready () -> void:
	manager = owner.get_node("StateManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process (delta: float) -> void:
	#increment the timer so we do not constantly transition through states
	timer -= 1 * delta
	if timer <= 0 and changeable == false:
		timer_on = false
		timer = i_time
		changeable = true
		
	_action ()
	if changeable and response != "":
		manager.change(response)
		response = ""
		changeable = false

##Optional function for condition components if they want to check somethign every frame
func _action () -> void:
	pass
