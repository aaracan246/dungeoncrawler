extends Control

@onready var portrait: TextureRect = $MarginContainer/VBoxContainer2/HBoxContainer/Portrait
@onready var name_label: Label = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/NameLabel
@onready var health_bar: TextureProgressBar = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/HealthBar
@onready var mana_bar: TextureProgressBar = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/ManaBar



var player: Node = null

func set_player(player_node: Node):
	player = player_node
	update_ui()
	
	if player.has_signal("health_changed"):
		player.connect("health_changed", Callable(self, "on_health_changed"))
	
	if player.has_signal("mana_changed"):
		player.connect("mana_changed", Callable(self, "on_mana_changed"))

func update_ui():
	if player:
		name_label.text = player.name
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
		mana_bar.max_value = player.max_mana
		mana_bar.value = player.current_mana

func on_health_changed(current, max):
	health_bar.max_value = max
	health_bar.value = current
	
func on_mana_changed(current, max):
	mana_bar.max_value = max
	mana_bar.value = current
