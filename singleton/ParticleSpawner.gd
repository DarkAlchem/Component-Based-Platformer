extends Node2D

func create_particle(body:CharacterBody2D,ptype:int):
	var this_ghost = preload("res://Actors/ghost_anim.tscn").instantiate()
	this_ghost.position=player.position
	this_ghost.flip_h=animated_sprite_2d.flip_h
	get_tree().current_scene.add_child(this_ghost)
