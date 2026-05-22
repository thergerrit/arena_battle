extends CharacterBody2D
class_name BaseEnemy

#region variabes

var direction : Vector2 = Vector2.ZERO
@export var speed : int = 10
@export var defense : int = 0

@onready var animator : AnimationPlayer = $BaseAnimationPlayer
@onready var health : HealthComponent = $HealthComponent

signal damaged

#endregion

#region base functions

#function to activate the health component to take damage
func _on_hurtbox_hit(amount: int) -> void:
	animator.play("hit")
	health.take_damage(amount - defense)
	damaged.emit()

#TODO: use a node pooling system for enemies, but we will worry about that later
func _on_health_component_died() -> void:
	queue_free()

#endregion
