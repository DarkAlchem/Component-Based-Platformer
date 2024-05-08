class_name DashComponent
extends Node

@export_subgroup('Node')
@export var dash_timer:Timer
@export var sprite:AnimatedSprite2D

@export_subgroup('Settings')
@export var dash_speed:float = 160.0
@export var dash_ghost:bool=false
@export var can_dash_jump:bool=false
@export var can_air_dash:bool=false

var can_dashing:bool=false
var dash_jump:bool=false
var is_dashing:bool=false
var dash_dir:int=0;

func handle_dash(body:CharacterBody2D,direction:float,await_dash:bool,await_jump:bool) -> void:
	if body.is_on_floor() and !is_dashing:
		can_dashing=true
		dash_jump=false
		
	if body.is_on_wall():
		dash_jump=false
		
	if can_dash(await_dash):
		if !body.is_on_floor() and !can_air_dash: return
		is_dashing=true
		can_dashing=false
		dash_dir=direction
		if dash_dir==0:
			if sprite.flip_h: dash_dir=-1
			if !sprite.flip_h: dash_dir=1
		dash_timer.start()
		
	if handle_dash_jump(body,await_jump):
		dash_timer.stop()
		is_dashing=false
		dash_jump=true
		
	if end_dash_conditions(direction) or air_dash_disallowed(body):
		dash_timer.stop()
		if direction==0: body.velocity.x=0
		
	if player_collides_wall(body):
		is_dashing=false
		dash_dir=0
		body.velocity.x=0
		
	if is_dashing:
		body.velocity.x = dash_dir*dash_speed
		if !dash_jump: body.velocity.y = 0	
		
func handle_dash_jump(body,await_jump) -> bool:
	return !dash_timer.is_stopped() and can_dash_jump and await_jump and body.is_on_floor()
		
func end_dash_conditions(direction):
	return is_dashing and !dash_timer.is_stopped() and direction == dash_dir*-1
		
func player_collides_wall(body)-> bool:
	return is_dashing and (dash_timer.is_stopped() or body.is_on_wall())
		
func air_dash_disallowed(body)-> bool:
	return is_dashing and !dash_timer.is_stopped() and !can_air_dash and !body.is_on_floor()
		
func is_currently_dashing() -> bool:
	return is_dashing or dash_jump
	
func can_dash(await_dash:bool) -> bool:
	return await_dash and can_dashing and !is_dashing and dash_timer.is_stopped()
