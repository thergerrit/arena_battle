extends BulletHitbox

@export var speed : float = 5
@export var max_distance : float = 3
@export var owner_group : String = "player"

var move_dir : Vector2
var distance_traveled : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process (delta: float) -> void:
	if visible:
		translate(move_dir * speed * delta)
		distance_traveled += speed * delta
		rotation = move_dir.angle()
	
	if distance_traveled > max_distance:
		visible = false
		is_spent = true

# Call this when the slash is retrieved from the pool
func activate_slash(direction: Vector2, slash_position: Vector2) -> void:
	move_dir = direction
	global_position = slash_position
	visible = true
	distance_traveled = 0.0
	is_spent = false
	hit_enemies.clear()  # Reset pierced enemies
	rotation = move_dir.angle()
