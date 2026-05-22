extends Node
class_name HealthComponent

signal health_changed(hp_current : int, hp_max : int)
signal died

@export var max_health : int = 10
@onready var cur_health : int = max_health

func _ready() -> void:
	cur_health = max_health


func take_damage (amount : int) -> void:
	#handle 0 and negative damages
	if amount <= 0: return
	
	#keep health as int
	cur_health = clampi(cur_health - amount, 0, max_health)
	health_changed.emit(cur_health, max_health)
	
	if cur_health <= 0:
		died.emit()
