extends Control

func _ready():
	
	var continueButton = get_node("MarginContainer/Options/Continue")
	var newGameButton = get_node("MarginContainer/Options/NewGame")
	var quitButton = get_node("MarginContainer/Options/Quit")
	
	if not has_saved_game():
		continueButton.disabled = true

func _on_continue_pressed():
	if has_saved_game():
		load_saved_game()
	else:
		print("No hay partida guardada.")

func _on_new_game_pressed():
	print("Iniciando nueva partida...")
	SaveManager.clear_save()  
	LoadingScreen.load_scene_async("res://scenes/prologue.tscn")
	LoadingScreen.show_loading_screen(1.0)

func _on_quit_pressed():
	print("Saliendo del juego...")
	get_tree().quit()

func has_saved_game() -> bool:
	return FileAccess.file_exists("user://savegame.save")

func load_saved_game():
	print("Cargando partida guardada...")
	await LoadingScreen.show_loading_screen(1.0)
	SaveManager.load_game() 
	LoadingScreen.hide_loading_screen()
	
