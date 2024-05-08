class_name FireSet
extends Node2D

@export_subgroup('Nodes')
@export var health_component:HealthComponent
@export var fire_component:FireComponent
@export var hitbox_collider:Area2D

@export_subgroup('Settings')
@export var max_health:int=20
@export var touch_damage:int=10
@export var proj_damage:int=3
@export var fire_type:int=1

func _ready()->void:
	add_to_group('Enemies')
	health_component.init_health(max_health)
	fire_component.init(fire_type)

func _physics_process(_delta):
	fire_component.handle_health(health_component.health,health_component.max_health)

func take_damage_from_player(val:float):
	health_component.handle_health(val)
	fire_component.handle_damage_flash()
	if health_component.health<=0:
		HitStopManager.hit_stop_half();
		queue_free()
	pass
