extends Node3D

signal battle_started
signal battle_ended

var saved_scene_pack: PackedScene = null
var previous_player_transform: Transform3D

var scene_copy: Node = null

func start_battle():
	print("Guardando estado actual...")
	SaveManager.save_game()

	emit_signal("battle_started")
	await LoadingScreen.show_loading_screen(1.0)

	# Cambiar a escena de batalla
	get_tree().change_scene_to_file("res://scenes/battlescene_ui.tscn")

	await get_tree().process_frame
	await get_tree().process_frame

	LoadingScreen.hide_loading_screen()

	var combat_manager = get_tree().current_scene.get_node_or_null("combatManager")
	if combat_manager:
		combat_manager.connect("battle_ended", Callable(self, "_on_battle_ended"))
	else:
		push_error("No se encontró CombatManager en la escena de batalla")


func end_battle():
	print("Cargando estado previo a la batalla...")
	await LoadingScreen.show_loading_screen(1.0)
	ScoreManager.add_points(100)
	await SaveManager.load_game() 

	LoadingScreen.hide_loading_screen()
	emit_signal("battle_ended")


func _on_battle_ended(winner: String):
	print("Combate terminado. Ganador:", winner)
	end_battle()

func set_owners_recursive(node: Node, new_owner: Node):
	for child in node.get_children():
		child.set_owner(new_owner)
		set_owners_recursive(child, new_owner)
