class_name GravityComponent
extends Node

@export_subgroup('nodes')
@export var hazard_node:Area2D

@export_subgroup('setting')
@export var gravity:float = 1000.0
@export var max_fall_speed:float = 400.0
@export var water_fall_speed:float = 200.0

var is_falling:bool=false

func handle_gravity(body,delta:float,in_water:bool) -> void:
	var fall_speed=max_fall_speed
	if in_water: fall_speed=water_fall_speed
		
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
		if body.velocity.y > fall_speed: body.velocity.y = fall_speed
		
	is_falling = body.velocity.y > 0 and not body.is_on_floor()
	
