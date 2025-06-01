extends Control

func _ready():
	
	var continueButton = get_node("MarginContainer/Options/Continue")
	var newGameButton = get_node("MarginContainer/Options/NewGame")
	var quitButton = get_node("MarginContainer/Options/Quit")
	
	#continueButton.pressed.connect(_on_continue_pressed)
	#newGameButton.pressed.connect(_on_new_game_pressed)
	#quitButton.pressed.connect(_on_quit_pressed)
	
	if not has_saved_game():
		continueButton.disabled = true

func _on_continue_pressed():
	if has_saved_game():
		load_saved_game()
	else:
		print("No hay partida guardada.")

func _on_new_game_pressed():
	print("Iniciando nueva partida...")
	get_tree().change_scene_to_file("res://scenes/ui.tscn")

func _on_quit_pressed():
	print("Saliendo del juego...")
	get_tree().quit()

func has_saved_game() -> bool:
	return FileAccess.file_exists("user://savegame.save")

func load_saved_game():
	print("Cargando partida guardada...")
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")  
