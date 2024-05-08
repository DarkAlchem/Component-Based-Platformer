extends Node2D

@export_subgroup('Nodes')
@export var gravity_component:GravityComponent
@export var health_component:HealthComponent
@export var move_component:MoveComponent
@export var crawler_component:CrawlerComponent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	crawler_component.handle_crawling()
	gravity_component.handle_gravity(self,delta,false)
	move_component.handle_horizontal_movement(self,1)
