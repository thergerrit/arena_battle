##Dash at the current enemy direction until the timer runs out
##All you have to do is connect the timer out signal to here, not set the time
class_name DashState
extends BaseState

@export var time : float = 3.0
@export var speed : float
@export var slow_down : float = 0.0
@onready var timer : Timer = $Timer
var timeout : bool = false

signal time_out

func enter () -> void:
	super.enter()
	timer.start(time)

func _action (delta : float) -> void:
	
	if timeout:
		if enemy.velocity <= Vector2(0.1, 0.1):
			time_out.emit()
			timeout = false
		else:
			enemy.velocity = enemy.velocity.lerp(Vector2.ZERO, slow_down)
	else:
		enemy.velocity = enemy.velocity.lerp(speed * enemy.direction, 5.0 * delta)
	
	enemy.move_and_slide()


func _on_timer_timeout() -> void:
	timeout = true
	
