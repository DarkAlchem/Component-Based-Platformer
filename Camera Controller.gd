extends Area2D

@export_subgroup('Nodes')
@export var shape2D:CollisionShape2D 

@export_subgroup('Settings')
@export var top_left_clamp:Vector2i
@export var bottom_right_clamp:Vector2i

func _on_body_entered(body):
	body.adjust_camera(top_left_clamp,bottom_right_clamp)
	pass # Replace with function body.
