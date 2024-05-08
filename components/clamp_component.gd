class_name PositionClampComponent
extends Node2D

@export var actor: Node2D
@export var margin:int=0

var left_border=0
var right_border= ProjectSettings.get_setting("display/window/size/viewport_width")

func process(delta:float)-> void:
	actor.global_position=clamp((actor.global_position.x, left_border+margin, right_border-margin))
