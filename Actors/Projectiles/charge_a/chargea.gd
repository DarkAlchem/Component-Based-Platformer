extends Area2D

@export_subgroup('Nodes')
@export var sprite:Sprite2D
@export var scale_component:ScaleComponent

@export_subgroup('Settings')
@export var speed:float = 150

var dir:float=0
var velocity:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
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

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.

func _on_body_entered(body):
	queue_free()
	pass # Replace with function body.
