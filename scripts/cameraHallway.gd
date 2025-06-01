extends Camera3D

@export var loop_distance: float = 20.0
@export var speed: float = 1.5
@export var move_direction: Vector3 = Vector3.FORWARD
@export var fade_duration: float = 0.1

var start_position: Vector3
var fading: bool = false
var animation_player: AnimationPlayer



func _ready():
	start_position = global_position
	animation_player = get_node("../CanvasLayer/AnimationPlayer")


func _process(delta: float) -> void:
	if fading:
		return

	global_position += move_direction * speed * delta

	var dist_moved = global_position.distance_to(start_position)

	if dist_moved >= loop_distance:
		_start_fade_and_reset()

func _start_fade_and_reset():
	fading = true
	print(animation_player)
	animation_player.play("fade_out")
	await animation_player.animation_finished
	global_position = start_position
	animation_player.play("fade_in")
	await animation_player.animation_finished
	fading = false
