extends Control

signal attack_pressed
signal pass_pressed

@onready var attack_button = $VBoxContainer/AttackButton
@onready var pass_button = $VBoxContainer/PassButton

func _ready():
	attack_button.pressed.connect(_on_attack_button_pressed)
	pass_button.pressed.connect(_on_pass_button_pressed)

func _on_attack_button_pressed():
	emit_signal("attack_pressed")

func _on_pass_button_pressed():
	emit_signal("pass_pressed")

func show_player_options():
	attack_button.disabled = false
	pass_button.disabled = false
