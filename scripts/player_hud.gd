extends Control

@onready var portrait: TextureRect = $MarginContainer/VBoxContainer2/HBoxContainer/Portrait
@onready var name_label: Label = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/NameLabel
@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/HealthBar
@onready var mana_bar: ProgressBar = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/ManaBar

var player: Node = null

func _ready():
	if player == null:
		var auto_player = get_tree().get_first_node_in_group("player")
		if auto_player:
			set_player(auto_player)

func set_player(player_node: Node):
	player = player_node
	update_ui()
	
	if player.has_signal("health_changed"):
		player.connect("health_changed", Callable(self, "on_health_changed"))
	
	if player.has_signal("mana_changed"):
		player.connect("mana_changed", Callable(self, "on_mana_changed"))

func update_ui():
	if player:
		name_label.text = "Priscilla"
		health_bar.max_value = PlayerEstado.max_hp
		health_bar.value = PlayerEstado.current_hp
		mana_bar.max_value = PlayerEstado.max_mana
		mana_bar.value = PlayerEstado.current_mana

func on_health_changed(current, max):
	health_bar.max_value = max
	health_bar.value = current

func on_mana_changed(current, max):
	mana_bar.max_value = max
	mana_bar.value = current
