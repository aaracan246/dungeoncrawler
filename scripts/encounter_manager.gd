extends Node

@export var combat_chance: float = 0.05

func _ready():
	await wait_for_player()
	#player.connect("step_completed", Callable(self, "_on_player_step"))

func _on_player_step():
	if randf() < combat_chance:
		print("¡Encuentro aleatorio!")
		await GameManager.start_battle()


func wait_for_player():
	var player: Node = null

	while player == null or not player.has_signal("step_completed"):
		await get_tree().process_frame
		player = get_tree().get_first_node_in_group("player")

	player.connect("step_completed", Callable(self, "_on_player_step"))
