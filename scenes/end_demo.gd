extends Control

@onready var name_input := $MarginContainer/VBoxContainer/LineEdit
@onready var score_label := $MarginContainer/VBoxContainer/HBoxContainer/Score
@onready var submit_button := $MarginContainer/VBoxContainer/Button
@onready var clasificacion_button := $MarginContainer/VBoxContainer/Button2

func _ready():
	var final_score = ScoreManager.get_score()
	score_label.text = "Puntuación: " + str(final_score)

	submit_button.pressed.connect(_on_submit_pressed)
	clasificacion_button.pressed.connect(_on_clasificacion_pressed)

func _on_submit_pressed():
	var player_name = name_input.text.strip_edges()
	if player_name == "":
		print("Introduce un nombre válido.")
		return

	var score = ScoreManager.get_score()
	print("Guardando puntuación:", player_name, score)
	
	ApiGlobal.send_score(player_name, score)
	
func _on_clasificacion_pressed():
	get_tree().change_scene_to_file("res://scenes/clasificacion.tscn")
