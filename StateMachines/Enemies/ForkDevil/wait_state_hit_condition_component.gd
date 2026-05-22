extends ConditionComponent


func _on_wait_state_hit_time_out() -> void:
	response = "slow"
	changeable = true


func _on_fork_devil_damaged() -> void:
	if process_mode == Node.PROCESS_MODE_DISABLED:
		return
	var remaining : float = get_parent().timer.time_left
	print("hit added to timer in wait")
	get_parent().timer.start(remaining + get_parent().wait_time)
