extends Node2D


@export var gun_hold_distance : float = 4.0
@export var shoot_rate : float = 0.25
var last_shot : float

@onready var bullet_pool : Node = $Bullet_Pool

@onready var muzzle : Marker2D = $Muzzle
@onready var gun_pivot : Marker2D = %Pivot
@onready var animator : AnimationPlayer = $AnimationPlayer

func _process (_delta: float) -> void:
	
	_update_position()
	
	_check_shoot()
	
##Checks if the gun can shoot and then executes shoot if button pressed.
func _check_shoot () -> void:
	if Input.is_action_pressed("attack"):
		if Time.get_unix_time_from_system() - last_shot > shoot_rate:
			_shoot()

##Updates gun position and rotation to follow the mouse.
func _update_position () -> void:
	
	var mouse_dir : Vector2 = gun_pivot.global_position.direction_to(get_global_mouse_position())
	
	global_position = gun_pivot.global_position + mouse_dir * gun_hold_distance

	scale.y = 1 if mouse_dir.x > 0 else -1
	
	show_behind_parent = mouse_dir.y < 0
	look_at(get_global_mouse_position())

##Function to shoot: creates bullet from gun.
func _shoot () -> void:
	last_shot = Time.get_unix_time_from_system()
	
	var bullet : Hitbox = bullet_pool.spawn()
	
	bullet.global_position = muzzle.global_position
	
	bullet.move_dir = Vector2.RIGHT.rotated(muzzle.global_rotation)
	animator.play("Shoot")
