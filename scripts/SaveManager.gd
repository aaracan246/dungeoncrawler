extends Node

const SAVE_PATH := "user://savegame.save"

#func save_game():
	#var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	#if file:
		#var scene_path = get_tree().current_scene.scene_file_path
		#file.store_line(scene_path)
		#file.close()
		#print("Guardado:", scene_path)

func save_game():
	var player = get_tree().get_first_node_in_group("player")
	#if players.size() == 0:
		#push_error("No se encontró ningún nodo en el grupo 'player'")
		#return
	
	#var player = players[0]

	var save_data = {
		"scene": get_tree().current_scene.scene_file_path,
		"player_transform": player.global_transform
	}
	print(save_data)

	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if file:
		file.store_var(save_data)
		file.close()
		print("Partida guardada con éxito.")

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		printerr("No se encontró partida guardada")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("No se pudo abrir el archivo de guardado.")
		return

	var save_data = file.get_var()
	file.close()

	if typeof(save_data) != TYPE_DICTIONARY or not save_data.has("scene") or not save_data.has("player_transform"):
		push_error("Datos de guardado corruptos o incompletos.")
		return

	var scene_path = save_data["scene"]
	var player_transform = save_data["player_transform"]

	print("Cargando:", scene_path)
	
	# Cambiar a la escena cargada
	var error = get_tree().change_scene_to_file(scene_path)
	if error != OK:
		push_error("No se pudo cargar la escena: " + scene_path)
		return

	await get_tree().process_frame
	await get_tree().process_frame

	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		player.global_transform = player_transform
		print("Posición restaurada.")
	else:
		push_error("No se encontró el nodo 'player' tras cargar la escena.")

func has_saved_game() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func clear_save():
	if FileAccess.file_exists(SAVE_PATH):
		var dir = DirAccess.open("user://")
		if dir:
			dir.remove("savegame.save")
