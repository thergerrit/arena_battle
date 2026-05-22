extends Node2D

@export var shoot_rate : float = 1
var last_shot : float

@onready var bullet_pool : Node = $NodePool

@onready var muzzle : Marker2D = $Muzzle

func _process (delta: float) -> void:
	
	_check_shoot()
	
##Checks if the gun can shoot and then executes shoot if button pressed.
func _check_shoot () -> void:
	if Time.get_unix_time_from_system() - last_shot > shoot_rate:
		_shoot()

##Function to shoot: creates bullet from gun.
func _shoot () -> void:
	last_shot = Time.get_unix_time_from_system()
	
	var bullet = bullet_pool.spawn()
	get_tree().root.add_child(bullet)
	
	bullet.global_position = muzzle.global_position

	
	bullet.move_dir = Vector2.RIGHT
	


func _on_hurtbox_hit(amount: int) -> void:
	print("hit")
	queue_free()
