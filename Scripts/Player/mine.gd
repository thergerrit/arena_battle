extends BulletHitbox

@export var max_speed : float = 40
@export var owner_group : String = "player"
@onready var animator : AnimationPlayer = $MineAnimationPlayer
var speed : float = max_speed
var move_dir : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if visible:
		translate(move_dir * speed * delta)
		speed = 1.45 * (max_speed * speed) * delta
		rotation = move_dir.angle()


func _on_visibility_changed() -> void:
	if visible == true and animator:
		speed = max_speed
