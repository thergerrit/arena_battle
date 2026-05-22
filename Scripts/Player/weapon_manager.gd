extends Node

@export var _weapons : Dictionary[String, NodePath] = {
	"slot_0": "Gun",
	"slot_1": "Sword",
	"slot_2": "MineThrower"
}

var cur_item : String = "slot_0"

func _ready() -> void:
	if not _weapons.is_empty():
		_activate()


# Check if a button is being pressed to switch weapons
func _process(_delta: float) -> void:
	for value : String in _weapons:
		if Input.is_action_pressed(value):
			cur_item = value
			_activate()
			return

#function to activate the current item and deactivate the rest
func _activate (item : String = cur_item) -> void:
	for value : String in _weapons:
		if value == item:
			get_node(_weapons[value]).visible = true
			get_node(_weapons[value]).process_mode = Node.PROCESS_MODE_INHERIT
		else:
			get_node(_weapons[value]).visible = false
			get_node(_weapons[value]).process_mode = Node.PROCESS_MODE_DISABLED
