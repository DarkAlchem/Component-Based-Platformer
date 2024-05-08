class_name CrawlerComponent
extends Node

@export_subgroup('Nodes')
@export var wall_detectR:RayCast2D
@export var wall_detectL:RayCast2D
@export var floor_detectR:Area2D
@export var floor_detectL:Area2D

@export_subgroup('Setting')
@export var direction:float=1.0

func handle_crawling():
	if wall_detectR.is_colliding():
		print('Collided')
