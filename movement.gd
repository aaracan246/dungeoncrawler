extends Node3D

signal battle_triggered

@export var move_speed: float = 8.0
@export var rotation_speed: float = 5.0

@export var inv: Inv

@export var combat_chance: float = 0.05

var moving: bool = false
var rotating: bool = false

var target_position: Vector3
var target_rotation: float

@onready var raycast: RayCast3D = $ForwardRay

func _ready():
	add_to_group("player")
	moving = false
	rotating = false
	
	target_position = global_position
	target_rotation = rotation.y
	
	connect("battle_triggered", Callable(GameManager, "start_battle"))

func _physics_process(delta):
	if moving:
		move_toward_position(delta)
	elif rotating:
		rotate_toward_target(delta)
	else:
		handle_input()

func handle_input():
	if Input.is_action_just_pressed("ui_up"):
		if not raycast.is_colliding():
			var direction = -transform.basis.z.normalized()
			target_position = global_position + direction
			moving = true
	elif Input.is_action_just_pressed("ui_left"):
		target_rotation = fposmod(rotation.y + deg_to_rad(90), TAU)
		rotating = true
	elif Input.is_action_just_pressed("ui_right"):
		target_rotation = fposmod(rotation.y - deg_to_rad(90), TAU)
		rotating = true

func move_toward_position(delta):
	global_position = global_position.move_toward(target_position, move_speed * delta)
	if global_position.distance_to(target_position) < 0.01:
		global_position = target_position
		moving = false
		
		#Check de combate
		if randf() < combat_chance:
			#LoadingScreen.
			emit_signal("battle_triggered")

func rotate_toward_target(delta):
	rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)
	if abs(angle_difference(rotation.y, target_rotation)) < 0.01:
		rotation.y = target_rotation
		rotating = false
