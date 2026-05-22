##This component just waits, and optionally calls a function
##Connect the time_out signal to the ConditionComponent
##Ensure you manually add a timer as a chid
class_name WaitState
extends BaseState


@export var wait_time : float = 0.26
@export var function_name : String = ""
@export var function_owner : Node
##Where to call function, 0 for enter, 1 for action, 2 for exit
@export var call_func : Array[int] = [0]
@onready var timer : Timer = $Timer

signal time_out

func enter () -> void:
	super.enter()
	timer.stop()
	print("Exhausted state exiting, stopping animation")
	timer.start(wait_time)
	_call(0)

func _action (_delta : float) -> void:
	_call(1)

func exit () -> void:
	super.exit()
	timer.stop()
	_call(2)

func _on_timer_timeout() -> void:
	time_out.emit()

func _call (cur : int) -> void:
	if function_name:
		for time : int in call_func:
			if time == cur:
				function_owner.call(function_name)
