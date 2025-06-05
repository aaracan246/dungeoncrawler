extends Control

@onready var hud = $PlayerHUD
@onready var player = $SubViewportContainer/SubViewport/PlayerBattle

func _ready():
	hud.set_player(player)
