extends Node3D
class_name battle_enemy

@export var stats: CharacterStats
@onready var visual := $Sprite3D

func _ready():
	stats.current_hp = stats.max_hp
	stats.current_mana = stats.max_mana

func attack(target: Node):
	var damage = stats.attack - target.stats.defense
	damage = max(damage, 0)
	target.receive_damage(damage)

func special_attack(target: Node):
	var damage = (stats.attack + 10) - target.stats.defense
	damage = max(damage, 0)
	target.receive_damage(damage)

func receive_damage(amount: int):
	stats.current_hp -= amount
	red_splash()
	show_damage_text(amount)
	print("Enemigo recibió ", amount, " de daño. HP actual: ", stats.current_hp)

func show_damage_text(amount: int):
	var floating_text = get_tree().get_root().get_node("battlescene_UI/FloatingText")
	if floating_text:
		floating_text.start(str(amount), Vector2(160, 108))
	else:
		print("No se ha encontrado el nodo requerido.")

func red_splash():
	if not visual:
		return

	visual.modulate = Color(1, 0, 0) 
	await get_tree().create_timer(0.15).timeout
	visual.modulate = Color(1, 1, 1) 
