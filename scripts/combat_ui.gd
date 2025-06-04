extends Control

signal attack_pressed
signal pass_pressed
signal ready_for_connection
signal ability_pressed

# Path de los botones
@onready var attack_button = $VBoxContainer/AttackButton
@onready var ability_button = $VBoxContainer/AbilityButton
@onready var pass_button = $VBoxContainer/PassButton

func _ready():
	
	# Conectamos los botones
	attack_button.pressed.connect(_on_attack_button_pressed)
	ability_button.pressed.connect(_on_ability_button_pressed)
	pass_button.pressed.connect(_on_pass_button_pressed)
	
	emit_signal("ready_for_connection")

func _on_attack_button_pressed():
	emit_signal("attack_pressed")

func _on_ability_button_pressed():
	emit_signal("ability_pressed")     

func _on_pass_button_pressed():
	emit_signal("pass_pressed")

func show_player_options():
	attack_button.disabled = false
	ability_button.disabled = false
	pass_button.disabled = false
