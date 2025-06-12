extends Control

@export var player: battle_player

@onready var speed_label := $Speed
@onready var armor_label := $Armor
@onready var attack_label := $Attack
#@onready var hunger_label := $Hunger

func _ready():
	update_stats()

func update_stats():
	if not player or not player.stats:
		print("No se encontró el jugador o sus stats.")
		return

	speed_label.text = str(player.stats.speed)
	armor_label.text = str(player.stats.defense)
	attack_label.text = str(player.stats.attack)
	#hunger_label.text = "Hambre: " + str(player.stats.hunger)
