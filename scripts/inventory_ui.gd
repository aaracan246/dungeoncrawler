extends Control

@export var inventory: Inv
@export var player: battle_player
@onready var grid = $GridContainer


func _ready():
	update_ui()

func update_ui():
	for child in grid.get_children():
		child.queue_free()
	
	for item in inventory.items:
		var slot = preload("res://scenes/item_slot.tscn").instantiate()
		slot.set_item(item, player)
		grid.add_child(slot)
