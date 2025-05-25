extends Node

signal battle_ended(winner: String)

#@onready var player = get_parent().get_node("SubViewportContainer/SubViewport/PlayerBattle")
#@onready var enemy = get_parent().get_node("SubViewportContainer/SubViewport/HobGob")
#@onready var ui = get_parent().get_node("combat_UI")

var player: Node = null
var enemy: Node = null
var ui: Node = null

var is_player_turn = true

func _ready():
	await get_tree().process_frame
	await ensure_nodes_ready()
	await ui.ready_for_connection
	
	print("Player:", player, " has method attack? ", player.has_method("attack"))
	print("Enemy:", enemy, " has method attack? ", enemy.has_method("attack"))
	print("Player stats: ", player.stats)
	print("Enemy stats: ", enemy.stats)
	
	emit_signal("ready_for_connection") #Testing
	
	start_turn()

func start_turn():
	if is_player_turn:
		ui.show_player_options()
	else:
		enemy_turn()

func _on_attack_pressed():
	player.attack(enemy)
	if player == null:
		print("Player null")
	if enemy == null:
		print("Enemy null")
	check_battle_state()
	end_turn()

func _on_pass_pressed():
	end_turn()

func end_turn():
	is_player_turn = !is_player_turn
	start_turn()

func enemy_turn():
	print("¡El enemigo va a atacar!")
	await get_tree().create_timer(1.0).timeout
	enemy.attack(player)
	check_battle_state()
	end_turn()

func check_battle_state():
	if player.stats.current_hp <= 0:
		print("¡El jugador ha sido derrotado!")
		emit_signal("battle_ended", "enemy")
	elif enemy.stats.current_hp <= 0:
		print("¡El enemigo ha sido derrotado!")
		emit_signal("battle_ended", "player")

func ensure_nodes_ready():
	while not get_node_or_null("../SubViewportContainer/SubViewport/PlayerBattle"):
		await get_tree().process_frame
	while not get_node_or_null("../SubViewportContainer/SubViewport/HobGob"):
		await get_tree().process_frame
	while not get_node_or_null("../combat_UI"):
		await get_tree().process_frame

	player = get_node("../SubViewportContainer/SubViewport/PlayerBattle")
	print(player)
	enemy = get_node("../SubViewportContainer/SubViewport/HobGob")
	print(enemy)
	ui = get_node("../combat_UI")
	print(ui)
