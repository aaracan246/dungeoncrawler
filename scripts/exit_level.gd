extends Area3D

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file("res://scenes/endDemo.tscn")
