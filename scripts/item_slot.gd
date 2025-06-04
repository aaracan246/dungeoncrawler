extends TextureButton

var item: InvItem = null
var player: battle_player = null
@onready var label = get_node("Amount")

func set_item(new_item: InvItem, new_player: battle_player):
	item = new_item
	player = new_player
	
	if item:
		texture_normal = item.texture
		if label:
			label.text = str(item.uses_left)
	else:
		texture_normal = null
		if label:
			label.text = ""

func _pressed():
	
	if item and item.uses_left > 0 and player:
		if item.name == "health_pot":
			player.heal(item.heal_amount)
			item.uses_left -= 1
			label.text = str(item.uses_left)
			print("Se han restaurado ", item.heal_amount, " HP.")
		if item.name == "mana_pot":
			player.restore_mana(item.mana_amount)
			item.uses_left -= 1
			label.text = str(item.uses_left)
			print("Se han restaurado ", item.mana_amount, " MP.")
		if item.uses_left <= 0:
			disabled = true
			modulate = Color(0.5, 0.5, 0.5)
