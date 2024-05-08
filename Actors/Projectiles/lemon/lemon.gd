extends StaticBody2D

@export_subgroup('Nodes')
@export var sprite:Sprite2D
@export var scale_component:ScaleComponent
@export var screen_notifier:VisibleOnScreenNotifier2D
@export var hitbox_collider:Area2D

@export_subgroup('Settings')
@export var speed:float = 150
@export var power:int=1

var dir:float=0
var velocity:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_notifier.connect('screen_exited',_leave_screen)
	hitbox_collider.connect('body_entered',_on_body_entered)
	scale_component.tween_scale()
	
func set_direction(_dir:float):
	dir = !_dir
	if(dir==0):
		sprite.flip_h=true
		dir=-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = speed * dir
	position.x += velocity.x * delta
	pass


func _leave_screen():
	queue_free()
	pass # Replace with function body.

func _on_body_entered(body):
	if body.is_in_group('Enemies') and body.has_method('take_damage_from_player'):
		body.take_damage_from_player(power)
		queue_free()

	match body.name:	
		"Ground":
			queue_free()
	
