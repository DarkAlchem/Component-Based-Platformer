extends AnimatableBody2D

@export_subgroup('Nodes')
@export var player_trigger:Area2D

@export_subgroup('Settings')
@export var graphic_xy_origin:Vector2=Vector2(0,0)

@onready var collision_shape_2d = $CollisionShape2D
@onready var reappearing_timer = $ReappearTimer
@onready var disappearing_timer = $DisappearTimer
@onready var _sprite = $Sprite2D

var _steps:int=0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match _steps:
		1:
			disappearing_timer.start();
			_steps=2
		2:
			shake_platform()
		4:
			reappearing_timer.start();
			_steps=5
	pass
	
	if disappearing_timer.time_left==0.0 and _steps==2:
		_steps=3
		tweenPlatform()
		
	if _sprite.modulate.a<.25 and _steps==3:
		collision_shape_2d.disabled=true
		_steps=4
		
	if reappearing_timer.is_stopped() and _steps==5:
		_steps=0
		collision_shape_2d.disabled=false
		_sprite.position=Vector2.ZERO
		_sprite.modulate.a=1;
	

func tweenPlatform():
	var tween:Tween=get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(_sprite,'position:y',10,.25)
	tween.tween_property(_sprite,'modulate:a',0,.25)

func shake_platform():
	var rng = RandomNumberGenerator.new()
	_sprite.position.x= rng.randf_range(-1.5, 1.5)
	_sprite.position.y= rng.randf_range(-1.5, 1.5)

func _on_area_2d_body_entered(_body):
	if _steps==0: 
		_steps=1
