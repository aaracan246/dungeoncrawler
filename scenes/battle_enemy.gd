extends Node3D
class_name battle_enemy

@export var stats: CharacterStats

func attack(target: Node):
	var damage = stats.attack - target.stats.defense
	damage = max(damage, 0)
	target.receive_damage(damage)

func receive_damage(amount: int):
	stats.current_hp -= amount
	print("Enemigo recibió ", amount, " de daño. HP actual: ", stats.current_hp)
