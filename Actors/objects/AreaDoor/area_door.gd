extends Node2D

@export_subgroup('Nodes')

@export_subgroup('Settings')
@export var cameraA_top_left:Vector2
@export var cameraA_bot_right:Vector2
@export var cameraB_top_left:Vector2
@export var cameraB_bot_right:Vector2
@export_enum('none','blue','red','green','white') var key_type

@onready var barrier = %CollisionShape2D
@onready var doorTop = %DoorTop
@onready var doorBot = %DoorBot

var transition:bool=false
var lock_door:bool=false

func _ready():
	pass

func play_transition(body:CharacterBody2D,side:bool):
	transition=true
	body.prevent_player_input(true)
	doorTop.play('open')
	doorBot.play('open')
	barrier.disabled=true
	body.adjust_camera(adjust_camera_bounds(true),adjust_camera_bounds(false))
	await get_tree().create_timer(1.0).timeout
	if side: body.move_player(Vector2(-100,30));
	if !side: body.move_player(Vector2(100,30));
	await get_tree().create_timer(1.0).timeout
	doorTop.play('close')
	doorBot.play('close')
	if side: body.adjust_camera(cameraA_top_left,cameraA_bot_right)
	if !side: body.adjust_camera(cameraB_top_left,cameraB_bot_right)
	await get_tree().create_timer(.5).timeout
	doorTop.play('idle')
	doorBot.play('idle')
	barrier.disabled=false
	transition=false
	body.prevent_player_input(false)
	
func adjust_camera_bounds(val:bool):
	if val:
		return Vector2(self.position.x-160,self.position.y-180)
	else:
		return Vector2(self.position.x+160,self.position.y+40)
	
func lock_this_door(_var:bool):
	lock_door=_var

func _on_transition_right_body_entered(body):
	if !transition and !lock_door: play_transition(body,true)

func _on_transition_left_body_entered(body):
	if !transition and !lock_door: play_transition(body,false)
