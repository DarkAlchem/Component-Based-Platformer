class_name CameraComponent
extends Node

@export_subgroup('Nodes')
@export var camera:Camera2D

@export_subgroup('Settings')
@export var camera_offset_mul:float=0
@export var camera_offset_max:float=0

var camera_offset:float=0

func handle_camera(_direction)-> void:
	#camera_offset+=direction*camera_offset_mul
	#if camera_offset*direction < camera_offset_max: camera_offset=direction*camera_offset_max
	#camera.offset=Vector2(camera_offset,0)
	pass

func change_camera_clamp(_veca:Vector2i,_vecb:Vector2i):
	camera.position_smoothing_enabled=true
	camera.position_smoothing_speed=10
	camera.limit_smoothed=true
	camera.limit_top=_veca.y
	camera.limit_bottom=_vecb.y
	camera.limit_left=_veca.x
	camera.limit_right=_vecb.x
