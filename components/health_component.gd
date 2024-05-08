class_name HealthComponent
extends Node

@export_subgroup('Nodes')
@export var health_bar:ProgressBar

@export_subgroup('Settings')
@export var health:int=100

var max_health:int = health

func init_health(_health)->void:
	health=_health
	max_health=health

func handle_health(_health)->void:
	health-=_health
	if health<0:
		health==0
		
	if health_bar: health_bar._set_health(health)
		
	if health==0:
		HitStopManager.hit_stop_long()
	
