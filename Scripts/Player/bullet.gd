extends BulletHitbox

@export var speed : float = 20
@export var owner_group : String = "player"
@onready var destroy_timer : Timer = $DestroyTimer

var move_dir : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process (delta: float) -> void:
	translate(move_dir * speed * delta)
	rotation = move_dir.angle()


func _on_destroy_timer_timeout() -> void:
	visible = false


func _on_visibility_changed() -> void:
	if visible == true and destroy_timer:
		destroy_timer.start()


func _on_body_entered(_Body : Node2D) -> void:
	visible = false
