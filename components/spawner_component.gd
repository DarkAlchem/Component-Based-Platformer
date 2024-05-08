class_name SpawnerComponent
extends Node2D

func spawn(scene:PackedScene, global_position:Vector2, parent: Node = get_tree().current_scene):
	var instance = scene.instantiate()
	parent.addChild(instance)
	instance.global_position = global_position
	return instance

