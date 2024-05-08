class_name GhostComponent
extends Node

@export_subgroup('Nodes')
@export var player:CharacterBody2D
@export var animated_sprite_2d:AnimatedSprite2D
@export var dash_timer:Timer

func handle_ghost(is_dashing:bool,is_wallsliding:bool):
	if(is_wallsliding && is_dashing):
		is_dashing=false
	
	if(is_dashing && dash_timer.time_left==0.0):
		create_ghost()
		
	if(is_dashing && dash_timer.is_stopped()):
		dash_timer.start()
		
	
	
func create_ghost():
	var this_ghost = preload("res://Actors/ghost_anim.tscn").instantiate()
	var currentTexture: Texture2D = animated_sprite_2d.sprite_frames.get_frame_texture(animated_sprite_2d.animation, animated_sprite_2d.get_frame())
	this_ghost.position=player.position
	this_ghost.position.y+=animated_sprite_2d.position.y
	this_ghost.texture=currentTexture
	this_ghost.flip_h=animated_sprite_2d.flip_h
	get_tree().current_scene.add_child(this_ghost)
	
