class_name ParticleComponent
extends Node

@export_subgroup('Nodes')
@export var chargeParticle:CPUParticles2D
@export var dashParticleL:CPUParticles2D
@export var dashParticleR:CPUParticles2D
@export var shotParticleL:CPUParticles2D
@export var shotParticleR:CPUParticles2D
@export var djumpParticle:CPUParticles2D
@export var sprite:AnimatedSprite2D

var last_charge:int=0
var curr_direction:int=1

func handle_charge_particles(charge_levels)->void:
	if charge_levels > 0:
		if charge_levels==1:
			chargeParticle.speed_scale=.5
			chargeParticle.hue_variation_max=-.87
			chargeParticle.hue_variation_min=-.87
		if charge_levels==2: 
			chargeParticle.emitting=true
		if charge_levels==3: 
			chargeParticle.speed_scale=1
			chargeParticle.hue_variation_max=.27
			chargeParticle.hue_variation_min=.27
		if charge_levels==4: chargeParticle.speed_scale=1.5
		if charge_levels==5: chargeParticle.speed_scale=2
		if charge_levels==6: 
			chargeParticle.speed_scale=3
			chargeParticle.hue_variation_max=.92
			chargeParticle.hue_variation_min=-.89
	else:
		chargeParticle.emitting=false
		
func handle_djump_particles(is_falling,is_jumping:bool)->void:
	if is_falling and is_jumping:
		djumpParticle.emitting=true

func handle_dash_particles(is_moving:bool,direction:float)->void:
	if is_moving:
		if direction==1:
			dashParticleL.emitting=true
		elif direction==-1:
			dashParticleR.emitting=true
	
func handle_shot_particles(curr_charge:int)->void:
	if curr_charge==0 and last_charge>2:
		if !sprite.flip_h:
			color_shot_particles(shotParticleR)
			shotParticleR.emitting=true
		if sprite.flip_h:
			color_shot_particles(shotParticleL)
			shotParticleL.emitting=true
	last_charge=curr_charge;

func color_shot_particles(shotParticle:CPUParticles2D):
	if last_charge>=2 and last_charge<6:
		shotParticle.hue_variation_max=-.22
		shotParticle.hue_variation_min=-.22
	if last_charge==6:
		shotParticle.hue_variation_max=.95
		shotParticle.hue_variation_min=.95
