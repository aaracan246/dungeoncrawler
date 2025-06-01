extends Label

var velocity := Vector2(0, -50)
var lifetime := 1.5
var active := false

func start(text_to_show: String, start_pos: Vector2):
	text = text_to_show
	position = start_pos
	lifetime = 1.0
	#active = true
	visible = true

func _process(delta):

	position += velocity * delta
	lifetime -= delta
	if lifetime <= 0:
		visible = false
		#active = false
