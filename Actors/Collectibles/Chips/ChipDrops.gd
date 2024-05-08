extends CharacterBody2D

@export_subgroup('Scripts')
@export var gravity_component:GravityComponent
@export var animated_sprite:AnimatedSprite2D

@export_subgroup('Settings')
@export var chip_type:int=1
@export var chip_subtype:int=1

var chip_coretype:String='chip'

# Called when the node enters the scene tree for the first time.
func _ready():
	match chip_type:
		1:
			animated_sprite.play('Sword_Chip')
		2:
			animated_sprite.play('Shield_Chip')
		3:
			animated_sprite.play('Utility_Chip')
		4:
			animated_sprite.play('Fist_Chip')
		5:
			animated_sprite.play('Shot_Chip')
		_:
			animated_sprite.play('Misc_Chip')
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gravity_component.handle_gravity(self,delta,false)
	move_and_slide();
	pass


func _on_area_2d_body_entered(_body):
	queue_free();
