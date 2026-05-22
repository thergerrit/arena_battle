extends Hitbox
class_name BulletHitbox

@export var can_pierce : bool = false

var is_spent : bool = false
var hit_enemies : Array = []  # Track which hurtboxes we've already hit

func spawn_reset() -> void:
	is_spent = false
	monitoring = true
	monitorable = true
	visible = true
	hit_enemies.clear()  # Clear the list when respawning
