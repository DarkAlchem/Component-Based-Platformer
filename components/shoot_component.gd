class_name ShootComponent
extends Node

@export_subgroup('Nodes')
@export var markerA:Marker2D
@export var markerB:Marker2D
@export var sprite:AnimatedSprite2D
@export var charge_timer:Timer
@export var shoot_timer:Timer

@export_subgroup('Settings')
@export var projectile_type:int=1
@export var can_charge:bool=false

var proj:Node
var charge_levels:int=0
var is_shooting:bool=false

func handle_shoot_input(await_pressed:bool,await_hold:bool,await_released:bool):
	if await_pressed:
		create_projectile_type();
		update_shoot_timer()
	
	if await_hold:
		if charge_timer.is_stopped() and charge_levels<6: 
			charge_levels+=1;
			charge_timer.start()
	
	if await_released:
		if(charge_levels>2): 
			create_projectile_type();
			update_shoot_timer()
		charge_timer.stop()
		charge_levels=0
		
	if shoot_timer.is_stopped() and is_shooting:
		is_shooting=false
	
func update_shoot_timer()->void:
	is_shooting=true
	shoot_timer.start()

func create_projectile_type():
	var _power:int=1
	match projectile_type:
		1:
			if charge_levels < 3: proj=preload("res://Actors/Projectiles/lemon/lemon.tscn").instantiate()
			if charge_levels >= 3 and charge_levels < 6: 
				_power=4
				proj=preload("res://Actors/Projectiles/charge_a/chargea.tscn").instantiate()
			if charge_levels >= 6: 
				_power=9
				proj=preload("res://Actors/Projectiles/charge_b/chargeb.tscn").instantiate()
		2:
			pass
			
	get_tree().current_scene.add_child(proj)
	proj.power=_power;
	if !sprite.flip_h: proj.global_position = markerA.global_position
	if sprite.flip_h: proj.global_position = markerB.global_position
	proj.set_direction(sprite.flip_h)
			
func update_projectile_type(_val:int):
	projectile_type=_val
	create_projectile_type()
