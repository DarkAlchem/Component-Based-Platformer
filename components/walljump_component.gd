class_name WallJumpComponent
extends Node

@export_subgroup('Nodes')
@export var wall_jump_timer:Timer
@export var sprite:AnimatedSprite2D

@export_subgroup('Settings')
@export var wall_slide_speed:float=10.0
@export var wall_jump_power:float=-340.0

var is_wall_sliding:bool=false
var wall_direction:Vector2=Vector2.ZERO

func handle_wall_jump(body:CharacterBody2D,await_jump:bool)->void:
	if body.is_on_floor():
		wall_direction=Vector2.ZERO
	
	if body.is_on_wall() and !body.is_on_floor() and body.velocity.y>0 and wall_direction!=body.get_wall_normal():
		is_wall_sliding=true
		body.velocity.y=wall_slide_speed
		if body.get_wall_normal() == Vector2.LEFT: sprite.flip_h=true
		elif body.get_wall_normal() == Vector2.RIGHT: sprite.flip_h=false
			
	if !body.is_on_wall() and is_wall_sliding and wall_jump_timer.is_stopped():
		wall_jump_timer.start()
		
	if await_jump and wall_direction!=body.get_wall_normal() and (is_wall_sliding or !wall_jump_timer.is_stopped()):
		wall_jump(body)
		
	if !body.is_on_wall() or await_jump:
		is_wall_sliding=false

func wall_jump(body)-> void:
	wall_jump_timer.stop()
	if sprite.flip_h: 
		body.velocity.x=-200
		wall_direction=Vector2.LEFT
	if !sprite.flip_h: 
		body.velocity.x=200
		wall_direction=Vector2.RIGHT
	body.velocity.y=wall_jump_power;
	
