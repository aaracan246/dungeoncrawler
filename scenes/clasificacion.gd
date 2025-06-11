extends Control

@onready var label := $Label
@onready var button := $Button

func _ready():
	ApiGlobal.scores_received.connect(_on_scores_received)
	ApiGlobal.get_scores()

func _on_scores_received(scores: Array):
	var text := "\n\n"
	scores.sort_custom(func(a, b): return a["points"] > b["points"])

	for i in range(min(scores.size(), 10)):
		var entry = scores[i]
		var name = entry.get("name", "¿?")
		var points = entry.get("points", 0)
		text += str(i + 1) + ". " + name + ": " + str(points) + " pts\n"

	$Label.text = text
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
