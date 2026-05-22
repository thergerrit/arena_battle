extends Node2D


@export var hand_mine_hold_distance : float = 4.0
@export var shoot_rate : float = 1.5
@export var quantity : int = 3
var last_shot : float

@onready var mine_pool : Node = $MinePool

@onready var muzzle : Marker2D = $Muzzle
@onready var hand_mine_pivot : Marker2D = %Pivot

func _process (_delta: float) -> void:
	
	_update_position()
	
	_check_shoot()
	
##Checks if the hand_mine can shoot and then executes shoot if button pressed.
func _check_shoot () -> void:
	if Input.is_action_pressed("attack"):
		if Time.get_unix_time_from_system() - last_shot > shoot_rate and quantity > 0:
			_shoot()

##Updates hand_mine position and rotation to follow the mouse.
func _update_position () -> void:
	
	var mouse_dir : Vector2 = hand_mine_pivot.global_position.direction_to(get_global_mouse_position())
	
	global_position = hand_mine_pivot.global_position + mouse_dir * hand_mine_hold_distance

	scale.y = 1 if mouse_dir.x > 0 else -1
	
	show_behind_parent = mouse_dir.y < 0
	look_at(get_global_mouse_position())

##Function to shoot: creates mine from hand_mine.
func _shoot () -> void:
	quantity -= 1
	
	last_shot = Time.get_unix_time_from_system()
	
	var mine : Hitbox = mine_pool.spawn()
	
	mine.global_position = muzzle.global_position
	
	mine.move_dir = Vector2.RIGHT.rotated(muzzle.global_rotation)
	mine.animator.play("explode")
