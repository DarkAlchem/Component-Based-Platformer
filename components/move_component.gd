class_name MoveComponent
extends Node

@export_subgroup('Nodes')
@export var crouch_raya:RayCast2D
@export var crouch_rayb:RayCast2D
@export var sprite:AnimatedSprite2D

@export_subgroup('Settings')
@export var speed:float = 100.0
@export var ground_accel:float = 6.0
@export var ground_decel:float = 8.0
@export var air_accel:float = 10.0
@export var air_decel:float = 3.0

var dash_speed:float=0
var is_dashing:bool=false

func handle_horizontal_movement(body,direction:float) -> void:
	var velocity_change_speed:float = 0.0
	var velocity_speed:float=speed
	
	if body.is_on_floor():
		velocity_change_speed = ground_accel if direction !=0 else ground_decel
	else:
		velocity_change_speed = air_accel if direction !=0 else air_decel
	
	if is_dashing: velocity_speed=dash_speed
	
	body.velocity.x = move_toward(body.velocity.x,direction * velocity_speed, velocity_change_speed)
	if force_crouch(body): body.velocity.x=0
	
func handle_dash_speed(_dash_speed:float,_is_dashing:bool)->void:
	dash_speed=_dash_speed
	is_dashing=_is_dashing
	
func handle_damage_movement(body:CharacterBody2D,_is_damaged:bool,damage)->void:
	if !_is_damaged and damage!=0:
		if sprite.flip_h: body.velocity.x=150
		if !sprite.flip_h: body.velocity.x=-150
		body.velocity.y=-250
	
func force_crouch(body:CharacterBody2D)->bool:
	if crouch_raya==null || crouch_rayb==null: return false
	return (crouch_raya.is_colliding() or crouch_rayb.is_colliding()) and body.is_on_floor()
