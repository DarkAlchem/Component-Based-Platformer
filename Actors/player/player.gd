extends CharacterBody2D

@export_subgroup('Nodes')
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var move_component: MoveComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent
@export var dash_component: DashComponent
@export var camera_component: CameraComponent
@export var walljump_component: WallJumpComponent
@export var health_component: HealthComponent
@export var ghost_component: GhostComponent
@export var shoot_component: ShootComponent
@export var particle_component: ParticleComponent
@export var hazard_components: HazardComponent

@onready var health_bar = %"Health Bar"

var prev_input:bool=false
var target_position:Vector2=Vector2.ZERO

func _ready():
	health_bar.init_health(health_component.health)
	pass
	
func _physics_process(delta):
	#Set Physics/Input for the player
	gravity_component.handle_gravity(self,delta,hazard_components.in_water);
	
	move_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self,input_component.get_jump_input(),input_component.get_jump_input_released(),walljump_component.is_wall_sliding,move_component.force_crouch(self))
	dash_component.handle_dash(self,input_component.input_horizontal,input_component.get_dash_input(),input_component.get_jump_input())
	jump_component.handle_dash_jump(dash_component.is_dashing)
	move_component.handle_dash_speed(dash_component.dash_speed,dash_component.is_currently_dashing())
	walljump_component.handle_wall_jump(self,input_component.get_jump_input())
	ghost_component.handle_ghost(dash_component.is_currently_dashing(),walljump_component.is_wall_sliding)
	move_component.handle_damage_movement(self,hazard_components.itimer_is_active(),hazard_components.damage)
	
	#Automove Controller for Gates
	automove_controller()
	
	camera_component.handle_camera(input_component.input_horizontal)
	shoot_component.handle_shoot_input(input_component.get_attack_input(),input_component.get_attack_input_held(),input_component.get_attack_released())
	
	if !prev_input:
		#Handle particle effects
		particle_component.handle_shot_particles(shoot_component.charge_levels)
		particle_component.handle_charge_particles(shoot_component.charge_levels)
		particle_component.handle_dash_particles(is_moving_or_just_landed(),input_component.input_horizontal)
		particle_component.handle_djump_particles(animation_component.states=='fall',jump_component.is_going_up)
	
		#Set Animations for Player
		animation_component.handle_move_animation(self,input_component.input_horizontal,walljump_component.is_wall_sliding,move_component.force_crouch(self))
		animation_component.handle_jump_animation(jump_component.is_going_up,gravity_component.is_falling)
		animation_component.handle_dash_animation(dash_component.is_dashing)
		animation_component.handle_wallslide_animation(walljump_component.is_wall_sliding)
		animation_component.set_shoot_animation(shoot_component.is_shooting)
	
	#Reset Damage
	hazard_components.reset_damage()
	#Add Damage Animation
	move_and_slide()

func adjust_camera(_veca:Vector2i,_vecb:Vector2i):
	camera_component.change_camera_clamp(_veca,_vecb)
	
func is_moving_or_just_landed():
	return (self.is_on_floor() and animation_component.states=='fall') or (animation_component.states=='stand' and input_component.input_horizontal!=0)
	
func prevent_player_input(previnput):
	prev_input=previnput
	
func move_player(val:Vector2):
	target_position.x=val.x;
	target_position.y=val.y;
	
func automove_controller():
	if prev_input: self.velocity=Vector2.ZERO
	if target_position!=Vector2.ZERO:
		self.velocity.x=target_position.x
		self.velocity.y=0
		target_position.y-=1
		if target_position.y<=0:
			target_position=Vector2.ZERO
