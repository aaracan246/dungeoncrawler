extends Button

func _on_pressed() -> void:
	SaveManager.save_game()
	await LoadingScreen.show_loading_screen(1.0)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	LoadingScreen.hide_loading_screen()
