extends ConditionComponent

func _on_follow_state_slow_distance_reached() -> void:
	response = "fast"

func _on_fork_devil_damaged() -> void:
	if process_mode == Node.PROCESS_MODE_DISABLED:
		return
	print("Damage signal received in slow state")
	response = "hit"
