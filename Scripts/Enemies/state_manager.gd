class_name StateManager
extends Node

@export var starting_state : String = "slow"
var cur_state : BaseState
var last_state : BaseState = null

func _ready() -> void:
	for state : BaseState in get_children():
		if state.id == starting_state:
			cur_state = state
			cur_state.enter()
		else:
			state.exit()  # Disable all non-starting states
	assert(cur_state, "error: invalid starting_state")


func _process(_delta: float) -> void:
	if last_state != cur_state:
		last_state = cur_state

func change (target : String) -> void:
	if target != cur_state.id:
		for state : BaseState in get_children():
			if state.id == target:
				cur_state.exit()
				cur_state = state
				cur_state.enter()
				print("state manager:")
				print(cur_state)
				return
