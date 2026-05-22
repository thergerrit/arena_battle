##please ensure you insert an id for the state and use that id in the ConditionComponents
class_name BaseState
extends Node

var enemy : BaseEnemy
@export var id : String

#ideally do not over ride _process, just put all that you need in _action()
func _process (delta: float) -> void:
	_action(delta)

#ideally do not override _ready, just put all that you need in _call_ready()
func _ready () -> void:
	_call_ready()

##Called in _ready().
##Ensure you use super for all children.
func _call_ready () -> void:
	for component : Node in get_children():
		if component is ConditionComponent:
			component.timer_on = true
	enemy = get_parent().get_parent()
	assert(enemy, "Could not find enemy parent for state: " + name)

##Called every frame in process.
##Do not use super.
func _action (_delta : float) -> void:
	assert(false, "Function _action() not implemented in " + get_class())

##Called when state is left.
##Only if needed override this in the inheriting State but ensure super is used.
func enter () -> void:
	#reset the timer
	for component : Node in get_children():
		if component is ConditionComponent:
			component.timer = component.i_time
			component.changeable = false
			
	
	assert(id, "Please enter an id for " + get_parent().name)
	process_mode = Node.PROCESS_MODE_INHERIT
	_enable_tree(self)

##Called when state is left.
##Only if needed override this in the inheriting State but ensure super is used.
func exit () -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	
	
	# Clear all pending responses from condition components
	for component : Node in get_children():
		if component is ConditionComponent:
			component.response = ""
	
	_disable_tree(self)

##Function to enable all the children (including nested) of node.
func _enable_tree(node: Node) -> void:
	for child : Node in node.get_children():
		child.process_mode = Node.PROCESS_MODE_INHERIT
		_enable_tree(child)

##Function to disable all the children (including nested) of node.
func _disable_tree(node: Node) -> void:
	for child : Node in node.get_children():
		child.process_mode = Node.PROCESS_MODE_DISABLED
		_disable_tree(child)
