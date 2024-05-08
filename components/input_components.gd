class_name InputComponent
extends Node

var input_horizontal:float = 0.0

func _process(_delta) -> void:
	input_horizontal = Input.get_axis("move_left","move_right")
	
func get_jump_input() -> bool:
	return Input.is_action_just_pressed('but_jump')

func get_jump_input_released() -> bool:
	return Input.is_action_just_released('but_jump')

func get_dash_input() -> bool:
	return Input.is_action_just_pressed('but_dash')
	
func get_attack_input() -> bool:
	return Input.is_action_just_pressed('but_attack')
	
func get_attack_input_held() -> bool:
	return Input.is_action_pressed('but_attack')

func get_attack_released() -> bool:
	return Input.is_action_just_released('but_attack')
