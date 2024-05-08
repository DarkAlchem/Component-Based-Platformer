class_name HazardComponent
extends Node

@export_subgroup('Node')
@export var hazard_collider:Area2D
@export var health_component:HealthComponent
@export var animate_sprite:AnimatedSprite2D
@export var iframe_timer:Timer
@export var damage_timer:Timer
@export var body_collision:CharacterBody2D

var in_water:bool=false
var damage:int=0
var iframes:bool=false
var exit_danger:bool=false
var can_crush:Vector2=Vector2(0,0)

func _ready():
	connect('hurt_player',take_damage)
	hazard_collider.connect("body_entered",_on_hazard_entered)
	hazard_collider.connect("body_exited",_on_hazard_exited)

func _physics_process(_delta)->void:
	if iframe_timer.is_stopped() and iframes:
		iframes=false
		
	if exit_danger and iframe_timer.is_stopped():
		take_damage()
	
	#Check for Crush
	if !body_collision.is_on_floor() and !body_collision.is_on_ceiling():
		can_crush.y=0;
	
	if body_collision.is_on_floor():
		if can_crush.y==-1:
			health_component.handle_health(999)
		if can_crush.y!=1:
			can_crush.y=1;
	
	if body_collision.is_on_ceiling():
		if can_crush.y==1:
			health_component.handle_health(999)
		if can_crush.y!=-1:
			can_crush.y=-1;

func _on_hazard_entered(body)->void:
	if body.is_in_group('Enemies'):
		damage=body.touch_damage
		exit_danger=true
		
	if "chip_coretype" in body:
		match body.chip_coretype:
			'health':
				if (health_component.health!=health_component.max_health):
					HitStopManager.hit_stop_health();
				health_component.handle_health(-50)
				pass
			'chip':
				pass
		
	match body.name:
		"Water":
			in_water=true

func _on_hazard_exited(body)->void:
	if body.is_in_group('Enemies'):
		exit_danger=false
	
	match body.name:
		"Water":
			in_water=false

func itimer_is_active()->bool:
	return !iframe_timer.is_stopped()
	
func dtimer_is_active()->bool:
	return !damage_timer.is_stopped()

func take_damage()->void:
	if !iframes and exit_danger:
		var tween = create_tween();
		HitStopManager.hit_stop_short()
		tween.tween_property(animate_sprite,"material:shader_parameter/amount",1.0, 0.0)
		tween.tween_property(animate_sprite,"material:shader_parameter/amount",0.0, 0.1).set_delay(0.2)
		iframe_timer.start()
		damage_timer.start()
		iframes=true
		health_component.handle_health(damage)
	
func reset_damage()->void:
	if !exit_danger: damage=0
