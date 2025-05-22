extends Node3D

signal battle_started
signal battle_ended

var saved_scene_pack: PackedScene = null
var previous_player_transform: Transform3D

# Guardamos referencia al duplicado para uso en owner
var scene_copy: Node = null

func start_battle():
	print("Guardando estado actual...")

	var current_scene = get_tree().current_scene
	if not current_scene:
		push_error("No hay escena actual para guardar")
		return

	# Duplicamos la escena actual
	scene_copy = current_scene.duplicate()
	if not scene_copy:
		push_error("No se pudo duplicar la escena actual")
		return

	# Asignamos owner de forma recursiva para todos los nodos
	set_owners_recursive(scene_copy, scene_copy)

	# Empaquetamos la escena duplicada
	saved_scene_pack = PackedScene.new()
	var err = saved_scene_pack.pack(scene_copy)
	if err != OK:
		push_error("Error al empaquetar la escena duplicada: %s" % err)
		return

	# Guardamos posición del jugador
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		previous_player_transform = players[0].global_transform

	emit_signal("battle_started")

	# Cambiamos a escena de batalla
	get_tree().change_scene_to_file("res://scenes/battlescene_ui.tscn")

	# Para pruebas: terminar combate automáticamente tras 2s
	#await get_tree().create_timer(2.0).timeout
	#end_battle()
	await get_tree().process_frame
	await get_tree().process_frame 
	var combat_manager = get_tree().current_scene.get_node_or_null("combatManager")
	if combat_manager:
		combat_manager.connect("battle_ended", Callable(self, "_on_battle_ended"))
	else:
		push_error("No se encontró CombatManager en la escena de batalla")

func end_battle():
	print("Restaurando estado guardado...")

	if saved_scene_pack == null:
		push_error("No hay estado guardado para restaurar")
		return

	# Eliminamos escena actual (la de batalla)
	var current = get_tree().current_scene
	if current:
		current.queue_free()

	await get_tree().process_frame  # Esperamos al siguiente frame

	# Instanciamos escena restaurada
	var restored_scene = saved_scene_pack.instantiate()
	if not restored_scene:
		push_error("No se pudo instanciar la escena guardada")
		return

	get_tree().root.add_child(restored_scene)
	get_tree().current_scene = restored_scene

	# Restauramos la posición del jugador si existe
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		players[0].global_transform = previous_player_transform
	else:
		print("⚠ No se encontró ningún nodo con el grupo 'player'")

	emit_signal("battle_ended")

func _on_battle_ended(winner: String):
	print("⚔ Combate terminado. Ganador:", winner)
	end_battle()

func set_owners_recursive(node: Node, new_owner: Node):
	for child in node.get_children():
		child.set_owner(new_owner)
		set_owners_recursive(child, new_owner)
