class_name NodePool
extends Node

@export var node_scene : PackedScene
var cached_nodes : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _create_new () -> Node2D:
	var node : Node = node_scene.instantiate()
	cached_nodes.append(node)
	get_tree().get_root().add_child(node)
	return node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn () -> Area2D:
	for node : Node in cached_nodes:
		if node.visible == false:
			node.spawn_reset()
			return node
	
	return _create_new()
