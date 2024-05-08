class_name JumpComponent
extends Node

@export_subgroup('Settings')
@export var jump_power:float = -360.0

var is_jumping:bool=false

func handle_jump(body:CharacterBody2D,await_jump:bool):
	if await_jump and body.is_on_floor():
		body.velocity.y = jump_power
		
	is_jumping = body.velocity.y < 0 and not body.is_on_floor()
