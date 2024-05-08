class_name AdvancedJumpComponent
extends Node

@export_subgroup('Nodes')
@export var jump_buffer:Timer
@export var coyote_timer:Timer

@export_subgroup('Settings')
@export var jump_power:float = -360.0
@export var dash_jump_power:float = -420.0
@export var air_jump_max:int = 0

var is_going_up:bool=false
var is_jumping:bool=false
var last_frame_on_floor:bool=false
var air_jump:int=air_jump_max
var dash_jump:bool=false

func handle_jump(body:CharacterBody2D,await_jump:bool,jump_released:bool,on_wall:bool,force_crouch:bool) -> void:
	if body.is_on_floor():
		air_jump=air_jump_max;
		
	if has_just_landed(body):
		is_jumping=false
		
	# Controls buffer window for Jumping
	if is_allowed_to_jump(body,await_jump,force_crouch): 
		jump(body,1);
		
	# Controls Double Jump tonight
	if can_air_jump(body,await_jump,on_wall,force_crouch):
		jump(body,.8)
		air_jump-=1
		
	handle_coyote_time(body)
	handle_jump_buffer(body, await_jump)
	handle_jump_release(body, jump_released)
	
	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	last_frame_on_floor=body.is_on_floor()

func handle_coyote_time(body:CharacterBody2D) -> void:
	if has_just_stepped_off_ledge(body):
		coyote_timer.start()
		
	if not coyote_timer.is_stopped() and not is_jumping:
		body.velocity.y=0

func has_just_stepped_off_ledge(body:CharacterBody2D):
	return not body.is_on_floor() and last_frame_on_floor and not is_jumping

func has_just_landed(body:CharacterBody2D) -> bool:
	return body.is_on_floor() and not last_frame_on_floor and is_jumping

func is_allowed_to_jump(body:CharacterBody2D, await_jump:bool, force_crouch:bool) -> bool:
	return await_jump and !force_crouch and (body.is_on_floor() or not coyote_timer.is_stopped())
	
func can_air_jump(body:CharacterBody2D, await_jump:bool,on_wall:bool,force_crouch:bool) -> bool:
	return await_jump and !force_crouch and air_jump > 0 and !body.is_on_floor() and coyote_timer.is_stopped() and !on_wall

func handle_jump_buffer(body:CharacterBody2D,await_jump:bool):
	if await_jump and body.is_on_floor():
		jump_buffer.start()

func handle_jump_release(body:CharacterBody2D, jump_released:bool) -> void:
	if jump_released and is_going_up:
		if body.velocity.y <= -10: body.velocity.y=-10
		if body.velocity.y > -10: body.velocity.y=0

func handle_dash_jump(is_dash_jump):
	dash_jump=is_dash_jump

func jump(body,multi) -> void:
	if !dash_jump: body.velocity.y = jump_power*multi
	if dash_jump: body.velocity.y = dash_jump_power*multi
	jump_buffer.stop()
	is_jumping=true
	coyote_timer.stop()
	
