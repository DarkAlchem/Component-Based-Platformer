extends Node2D

@export_subgroup('Nodes')
@export var anima_body:AnimatableBody2D

@export_subgroup('Settings')
@export var offsetA:Vector2 = Vector2(0, 0)
@export var offsetB:Vector2 = Vector2(0, 0)
@export var offsetC:Vector2 = Vector2(0, 0)
@export var duration:float = 5.0
@export var delay_move:int=0
@export var player_activated:bool=false

#Add Initial Position
var platform_offset_multiplier=2
var is_active:bool=false
var effect_tween: Tween

func _ready():
	#add Initial Position
	update_multiplier()
	start_tween()

func start_tween():
	effect_tween = get_tree().create_tween()
	if player_activated: effect_tween.set_parallel(false)
	if !player_activated: effect_tween.set_loops().set_parallel(false)
	effect_tween.tween_property(anima_body, "position", offsetA, duration / platform_offset_multiplier).set_ease(Tween.EASE_IN_OUT)
	if delay_move!=0: effect_tween.tween_interval(delay_move)
	if (offsetB!= Vector2.ZERO): 
		effect_tween.tween_property(anima_body, "position", offsetB, duration / platform_offset_multiplier).set_ease(Tween.EASE_IN_OUT)
		if delay_move!=0: effect_tween.tween_interval(delay_move)
	if (offsetB!= Vector2.ZERO && offsetC!= Vector2.ZERO): 
		effect_tween.tween_property(anima_body, "position", offsetC, duration / platform_offset_multiplier).set_ease(Tween.EASE_IN_OUT)
		if delay_move!=0: effect_tween.tween_interval(delay_move)
	effect_tween.tween_property(anima_body, "position", Vector2.ZERO, duration / platform_offset_multiplier).set_ease(Tween.EASE_IN_OUT)
	if delay_move!=0: effect_tween.tween_interval(delay_move)
	
func update_multiplier():
	if (offsetA!= Vector2.ZERO && offsetB!= Vector2.ZERO): 
		platform_offset_multiplier+=1
		if (offsetB!= Vector2.ZERO && offsetC!= Vector2.ZERO):
			platform_offset_multiplier+=1
