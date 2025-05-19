extends Node3D

@export var stats: Stats_Resource

func take_damage(amount: int):
	stats.current_hp = max(stats.current_hp - amount, 0)
	if stats.current_hp == 0:
		die()

func die():
	print("Player has died")
