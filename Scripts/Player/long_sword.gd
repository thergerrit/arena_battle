extends Node2D


@export var sword_hold_distance : float = 2.3
@export var slash_rate : float = 0.25
var last_shot : float


@onready var slash_pool : Node = $NodePool
@onready var muzzle : Marker2D = $Animation/Tip
@onready var sword_pivot : Marker2D = %Pivot
@onready var animator : AnimationPlayer = $Animation/AnimationPlayer
@onready var sprites : Marker2D = $Animation

func _process (_delta: float) -> void:
	
	_update_position()
	
	_check_slash()
	
##Checks if the sword can slash and then executes slash if button pressed.
func _check_slash () -> void:
	if Input.is_action_just_pressed("attack"):
		if Time.get_unix_time_from_system() - last_shot > slash_rate:
			animator.play("Slash")

##Updates sword position and rotation to follow the mouse.
func _update_position () -> void:
	
	var mouse_dir : Vector2 = sword_pivot.global_position.direction_to(get_global_mouse_position())
	
	global_position = sword_pivot.global_position + mouse_dir * sword_hold_distance
	
	show_behind_parent = mouse_dir.y < 0
	look_at(get_global_mouse_position())

##Function to slash: creates slash from sword.
func _slash () -> void:
	
	last_shot = Time.get_unix_time_from_system()
	
	var slash : Node = slash_pool.spawn()
	
	slash.activate_slash(Vector2.UP.rotated(muzzle.global_rotation), muzzle.global_position)
	
