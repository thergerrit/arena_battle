extends CharacterBody2D

#variables for movement
@export var max_speed : int  = 30
@export var accelerate : float  = 0.5
@export var breaking : float = 0.5

@onready var player_sprite : Sprite2D = $Sprite2D
@onready var health : HealthComponent = $HealthComponent
@onready var animator : AnimationPlayer = $AnimationPlayer
var moveInput : Vector2


func _physics_process(_delta: float) -> void:
	
	moveInput = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	#flip character if needed
	if moveInput.x > 0: player_sprite.flip_h = false
	elif moveInput.x < 0: player_sprite.flip_h = true
	
	#implement movement
	if moveInput.length() > 0:
		velocity = velocity.lerp(moveInput * max_speed, accelerate)
	else:
		velocity = velocity.lerp(Vector2.ZERO, breaking)
	
	move_and_slide()

func _on_hurtbox_hit(amount: int) -> void:
	health.take_damage(amount)
	animator.play("hit")


func _on_health_component_died() -> void:
	print("death")
	queue_free()
