class_name Hurtbox
extends Area2D

@export var iframe_length : float = 0.1
var last_hit : float = Time.get_unix_time_from_system()

var active_hitboxes : Array = []

signal hit(amount : int)

func _process(_delta: float) -> void:
	for box : Area2D in active_hitboxes:
		_check_hits(box)

#checks for hits when an area enters
func _on_area_entered(area: Area2D) -> void:
	
	_check_hits(area)

#removes exited areas from active_hitboxes
func _on_area_exited(area: Area2D) -> void:
	if area in active_hitboxes:
		active_hitboxes.erase(area)

#function that actually checks for hits
func _check_hits (area : Area2D) -> void:
	#only run if we have not been hit for iframes_lenth
	if Time.get_unix_time_from_system() - last_hit > iframe_length:
		
		#update the last hit
		last_hit = Time.get_unix_time_from_system()
		
		#handle bullet hitboxes
		if area is BulletHitbox and area.visible == true:
			if area.can_pierce == true:
				# Check if we've already hit this hurtbox
				if area.hit_enemies.has(self):
					return
				area.hit_enemies.append(self)  # Mark this hurtbox as hit
			else:
				# Non-piercing hitboxes get fully disabled (deferred is safer)
				area.set_deferred("monitorable", false)
				area.set_deferred("monitoring", false)
				area.set_deferred("visible", false)
			
			# Emit the signal
			hit.emit(area.damage)
		
		#handle other hitboxes
		elif area is Hitbox:
			if area not in active_hitboxes:
				active_hitboxes.append(area)
			
			# Emit the signal
			hit.emit(area.damage)
