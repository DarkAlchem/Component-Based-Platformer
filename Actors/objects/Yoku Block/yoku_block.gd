extends Node2D

@export_subgroup('Node')

@export_subgroup('Settings')
@export var set_duration:float=5000.0
@export var yoku_steps:int=3
@export var visibility_steps:int=1
@export var visibility_duration:int=1
@export var graphic_location:Vector2=Vector2(0,0)

@onready var collision_node = %CollisionShape2D

var steps:float=0.0
var _visibility:bool=true

# Called when the node enters the scene tree for the first time.
func _ready():
	calc_yoku_time()
	toggle_visible(_visibility)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	calc_yoku_time()
	
	if self.modulate.a==0 && _visibility: 
		tweenVisible(true)
	elif self.modulate.a==1 && !_visibility:
		tweenVisible(false)
	
func tweenVisible(_show:bool):
	var tween:Tween = get_tree().create_tween();
	tween.set_parallel(false)
		
	if _show:
		toggle_visible(true)
		tween.tween_property(self, "modulate:a", 1, .25)
	else:
		tween.tween_property(self, "modulate:a", 0, .25)
		await get_tree().create_timer(.25,true)
		toggle_visible(false)
		
func toggle_visible(_val):
	if _val:
		collision_node.disabled=false
	else:
		collision_node.disabled=true
	
func calc_yoku_time():
	var _time= fmod(Time.get_ticks_msec(),(yoku_steps*set_duration))
	if _time > calc_as_time(visibility_steps-1) and _time < calc_as_time((visibility_steps-1)+visibility_duration):
		_visibility=true
	else:
		_visibility=false
	
func calc_as_time(_val):
	return _val*set_duration
