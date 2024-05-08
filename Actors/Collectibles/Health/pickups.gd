extends CharacterBody2D

@export_subgroup('Scripts')
@export var gravity_component:GravityComponent

var chip_coretype:String='health'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gravity_component.handle_gravity(self,delta,false)
	move_and_slide();
	pass


func _on_area_2d_body_entered(_body):
	queue_free();
