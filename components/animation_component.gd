class_name AnimationComponent
extends Node

@export_subgroup('Nodes')
@export var sprite: AnimatedSprite2D
@export var stand_hitbox:CollisionShape2D
@export var crouch_hitbox:CollisionShape2D

var states:String=''
var sprite_frame:float

func handle_horizontal_flip(move_direction:float,on_wall:bool) -> void:
	if move_direction == 0 or on_wall:
		return
		
	sprite.flip_h= false if move_direction > 0 else true

func handle_move_animation(body:CharacterBody2D,move_direction:float,on_wall:bool,force_crouch:bool) -> void:
	handle_horizontal_flip(move_direction,on_wall)
	
	if body.is_on_floor(): 
		if !force_crouch:
			if move_direction != 0:
				if states!='run':
					use_stand_hitbox(true)
					animation_states('run')
			else:
				use_stand_hitbox(true)
				animation_states('stand')
		else:
			animation_states('crouch')
		

func handle_jump_animation(is_jumping:bool,is_falling:bool)->void:
	if is_jumping:
		if states!='jump':
			use_stand_hitbox(true)
			animation_states('jump')
	elif is_falling:
		if states!='fall':
			use_stand_hitbox(true)
			animation_states('fall')
	
func handle_dash_animation(is_dashing:bool):
	if is_dashing && states!='dash':
		use_stand_hitbox(false)
		animation_states('dash')
		
func handle_wallslide_animation(is_wallsliding:bool):
	if is_wallsliding && states!='wall_slide':
		use_stand_hitbox(true)
		animation_states('wall_slide')
		
func animation_states(_states):
	states=_states;
	match states:
		'stand':
			sprite.play('stand')
		'crouch':
			sprite.play('crouch')
		'run':
			sprite.play('run')
		'jump':
			sprite.play('jump')
		'fall':
			sprite.play('fall')
		'dash':
			sprite.play('dash')
		'wall_slide':
			sprite.play('wall_slide')
		'damage':
			sprite.play('stand')
			
func set_shoot_animation(await_shoot:bool)->void:
	if await_shoot:
		if sprite_frame==0: sprite_frame=sprite.frame
	
		match states:
			'stand':
				sprite.play('stand_shoot')
			'jump':
				sprite.play('jump_shoot')
			'fall':
				sprite.play('fall_shoot')
			'run':
				sprite.play('run_shoot')
			'wall_slide':
				sprite.play('wall_slide_shoot')
			
func use_stand_hitbox(_show:bool)->void:
	if !_show:
		if stand_hitbox: stand_hitbox.disabled=true
		if crouch_hitbox: crouch_hitbox.disabled=false
	else:
		if stand_hitbox: stand_hitbox.disabled=false
		if crouch_hitbox: crouch_hitbox.disabled=true
		
