class_name FireComponent
extends Node

@export_subgroup('Nodes')
@export var smoke_effect:CPUParticles2D
@export var fire_effect:CPUParticles2D
@export var attack_frequency:Timer

var _gradient
var _smoke_gradient

func init(fire_type)->void:
	_gradient=fire_effect.color_ramp
	_smoke_gradient=smoke_effect.color_ramp
	match fire_type:
		2:
			fire_effect.hue_variation_min=-.1
			fire_effect.hue_variation_max=.12
		3:
			fire_effect.hue_variation_min=-.2
			fire_effect.hue_variation_max=.25

func handle_health(_hp:float,_hpmax:float)->void:
	var hp_percent:float =_hp/_hpmax
	var _spread:float=19*hp_percent
	var _scalemin:float=4*hp_percent
	var _scalemax:float=12*hp_percent
	var _gravity:float=(30+(50*hp_percent))*-1
	
	fire_effect.spread=2+_spread
	fire_effect.scale_amount_min=1+_scalemin
	fire_effect.scale_amount_max=3+_scalemax
	fire_effect.gravity.y=_gravity
	
	if hp_percent>.5: smoke_effect.emitting=true
	if hp_percent<=.5: smoke_effect.emitting=false
	smoke_effect.spread= 2+_spread
	smoke_effect.scale_amount_min=1+_scalemin
	smoke_effect.scale_amount_max=3+_scalemax
	smoke_effect.gravity.y=_gravity
	
	
func handle_damage_flash():
	#Create Hitflash
	fire_effect.color_ramp=null
	smoke_effect.color_ramp=null
	await get_tree().create_timer(.2,true,true).timeout
	fire_effect.color_ramp=_gradient
	smoke_effect.color_ramp=_smoke_gradient
