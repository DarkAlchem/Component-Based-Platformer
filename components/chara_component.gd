class_name CharaComponent
extends Resource

# Movement parameters
@export var speed: float = 200.0
@export var acceleration: float = 1000.0
@export var air_acceleration: float = 500.0
@export var jump_power: float = -800.0
@export var gravity: float = 2000.0
@export var ground_friction: float = 1000.0

# Coyote time parameters
var coyote_time: float = 0.1
var coyote_timer: float = 0.0

# Movement state
var velocity: Vector2 = Vector2.ZERO
var is_on_ground:bool=false
