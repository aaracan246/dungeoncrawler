extends Camera3D

@export var loop_distance: float = 30.0
@export var speed: float = 1.5
@export var move_direction: Vector3 = Vector3.FORWARD

var start_position: Vector3

func _ready():
	start_position = global_position

func _process(delta: float) -> void:
	global_position += move_direction * speed * delta

	var dist_moved = global_position.distance_to(start_position)

	if dist_moved >= loop_distance:
		global_position = start_position
