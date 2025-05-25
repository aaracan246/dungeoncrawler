extends Node3D
class_name battle_player

@export var stats: CharacterStats
@export var inv: Inv

func attack(target: Node):
	var damage = stats.attack - target.stats.defense
	damage = max(damage, 0)
	target.receive_damage(damage)

func receive_damage(amount: int):
	stats.current_hp -= amount
	print("Jugador recibió ", amount, " de daño. HP actual: ", stats.current_hp)

func heal(amount: int):
	stats.current_hp += amount
	stats.current_hp = clamp(stats.current_hp, 0, stats.max_hp)

func restore_mana(amount: int):
	stats.current_mana += amount
	stats.current_mana = clamp(stats.current_mana, 0, stats.max_mana)
