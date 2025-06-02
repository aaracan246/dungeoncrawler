extends Node

const SAVE_PATH := "user://savegame.save"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var scene_path = get_tree().current_scene.scene_file_path
		file.store_line(scene_path)
		file.close()
		print("Guardado:", scene_path)

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		printerr("No se encontró partida guardada")
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var scene_path = file.get_line()
	file.close()
	print("Cargando:", scene_path)
	get_tree().change_scene_to_file(scene_path)

func has_saved_game() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func clear_save():
	if FileAccess.file_exists(SAVE_PATH):
		var dir = DirAccess.open("user://")
		if dir:
			dir.remove("savegame.save")
