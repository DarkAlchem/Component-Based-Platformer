extends Node

func hit_stop_short():
	Engine.time_scale=0
	await get_tree().create_timer(0.1, true, false, true).timeout
	Engine.time_scale=1
	
func hit_stop_half():
	Engine.time_scale=.5
	await get_tree().create_timer(0.25, true, false, true).timeout
	Engine.time_scale=1
	
func hit_stop_medium():
	Engine.time_scale=0
	await get_tree().create_timer(0.25, true, false, true).timeout
	Engine.time_scale=1

func hit_stop_long():
	Engine.time_scale=0
	await get_tree().create_timer(1, true, false, true).timeout
	Engine.time_scale=1
	
func hit_stop_health():
	Engine.time_scale=.3
	await get_tree().create_timer(0.3, true, false, true).timeout
	Engine.time_scale=1
