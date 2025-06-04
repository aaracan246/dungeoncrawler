extends Control

@onready var portrait: TextureRect = $Portrait
@onready var name_label: Label = $NameLabel
@onready var health_bar: ProgressBar = $HealthBar

var player: Node = null

func set_player(player_node: Node):
	player = player_node
	update_ui()
	
	if player.has_signal("health_changed"):
		player.connect("health_changed", Callable(self, "on_health_changed"))

func update_ui():
	if player:
		name_label.text = player.name
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
		# Puedes configurar portrait.texture aquí si es dinámico

func on_health_changed(current, max):
	health_bar.max_value = max
	health_bar.value = current
