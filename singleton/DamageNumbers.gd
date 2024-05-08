extends Node

func display_number(value:int, position: Vector2, display_type:int=1):
	var number=Label.new()
	number.global_position=position
	number.text=str(value)
	number.z_index=10
	number.label_settings=LabelSettings.new()
	
	var color='#FFF'
	var outline_color='#000'
	match display_type:
		#Critical Damage Number
		2: 
			color='#F00'
			outline_color='#D00'
		#Non-effective Damage Number
		3: 
			color='#0F0'
			outline_color='#D00'
		#Heal Damage Number
		4: 
			color='#00F'
			outline_color='#D00'
			
	#Adjust Styles for Different Damage Numbers
	number.label_settings.font_color=color
	number.label_settings.font_size=18
	number.label_settings.outline_color=outline_color
	number.label_settings.outline_size=2
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset=Vector2(number.size/2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number,  "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number,  "position:y", number.position.y, 0.25
	).set_ease(Tween.EASE_IN).set_delay(.25)
	tween.tween_property(
		number, 'modulate:a', 0, .25 
	).set_ease(Tween.EASE_IN).set_delay(.5) 
	
	await tween.finished
	number.queue_free();
