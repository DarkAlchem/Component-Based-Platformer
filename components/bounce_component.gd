class_name BounceComponent
extends Node

@export var jump_power:float=180.0

var bounce_val=1

func handle_bounce(body):
	if bounce_val==1 and body.is_on_floor():
		bounce_val-=1
		body.velocity.y=jump_power*-1
		
