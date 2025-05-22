extends Node

@onready var player = get_parent().get_node("SubViewportContainer/SubViewport/PlayerBattle")
@onready var enemy = get_parent().get_node("SubViewportContainer/SubViewport/HobGob")
@onready var ui = get_parent().get_node("combat_UI")

var is_player_turn = true

func _ready():
	await get_tree().process_frame
	
	ui.connect("attack_pressed", Callable(self, "_on_attack_pressed"))
	ui.connect("pass_pressed", Callable(self, "_on_pass_pressed"))
	
	print("Player:", player, " has method attack? ", player.has_method("attack"))
	print("Enemy:", enemy, " has method attack? ", enemy.has_method("attack"))
	print("Player stats: ", player.stats)
	print("Enemy stats: ", enemy.stats)
	
	start_turn()

func start_turn():
	if is_player_turn:
		ui.show_player_options()
	else:
		enemy_turn()

func _on_attack_pressed():
	player.attack(enemy)
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
	elif enemy.stats.current_hp <= 0:
		print("¡El enemigo ha sido derrotado!")
