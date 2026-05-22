##This state moves the enemy toward the player
##it will automatically stop if stop_distance is not set to 0 and signal: distance_reached
##speed has to be manually set
##Connect distance_reached to ConditionComponent
class_name FollowState
extends BaseState


@export var stop_distance : float = 0
@export var update_time : float = 0.4
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@export var speed : float

var last_update : float = Time.get_unix_time_from_system()
var direction : Vector2
var target_velocity : Vector2

#connect this signal to the condition component
signal distance_reached

func _action (delta : float) -> void:
	if _target_player(delta, update_time, stop_distance):
		distance_reached.emit()

##The enemy follows the player at speed.Reevaluate time is the time it refocuses on the player, will continue to get closer to the player until the distance is reached
func _target_player (delta : float, reevaluate_time : float, distance : float = 0) -> bool:
		#only execute this code if we still have a player
		if player:

			#face toward the player and flip if we are in the wrong direction
			enemy.look_at(player.position)
			enemy.scale.y = 1 if player.position.x > enemy.position.x else -1
			
			# Update target direction less frequently
			if Time.get_unix_time_from_system() - last_update > reevaluate_time:
				last_update = Time.get_unix_time_from_system()
				enemy.direction = (player.global_position - enemy.global_position).normalized()
				# Add slight randomness to the target, not the normalized direction
				#enemy.direction += Vector2(randf_range(-0.1, 0.1), randf_range(-0.1, 0.1)).normalized() * 0.2
				#enemy.direction = direction.normalized()
			
			# Smoothly interpolate velocity toward target (every frame)
			target_velocity = speed * enemy.direction
			enemy.velocity = enemy.velocity.lerp(target_velocity, 5.0 * delta)
			enemy.move_and_slide()
		#return if we should continue
		if distance != 0 and distance >= player.global_position.distance_to(enemy.global_position):
			return true
		else:
			return false

func enter () -> void:
	super.enter()
	#keep these to reset when the enemy respawns in from node pooling
	direction = Vector2.ZERO
	target_velocity = Vector2.ZERO

func exit () -> void:
	super.exit()
	enemy.velocity = Vector2.ZERO
