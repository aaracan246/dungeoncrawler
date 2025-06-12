#extends Node3D
#class_name battle_enemy
#
#@export var stats: CharacterStats
#@onready var visual := $Sprite3D
#
#func _ready():
	#stats.current_hp = stats.max_hp
	#stats.current_mana = stats.max_mana
#
#func attack(target: Node):
	#var damage = stats.attack - target.stats.defense
	#damage = max(damage, 0)
	#target.receive_damage(damage)
#
#func special_attack(target: Node):
	#var damage = (stats.attack + 10) - target.stats.defense
	#damage = max(damage, 0)
	#target.receive_damage(damage)
#
#func receive_damage(amount: int):
	#stats.current_hp -= amount
	#red_splash()
	#show_damage_text(amount)
	#print("Enemigo recibió ", amount, " de daño. HP actual: ", stats.current_hp)
#
#func show_damage_text(amount: int):
	#var floating_text = get_tree().get_root().get_node("battlescene_UI/FloatingText")
	#if floating_text:
		#floating_text.start(str(amount), Vector2(160, 108))
	#else:
		#print("No se ha encontrado el nodo requerido.")
#
#func red_splash():
	#if not visual:
		#return
#
	#visual.modulate = Color(1, 0, 0) 
	#await get_tree().create_timer(0.15).timeout
	#visual.modulate = Color(1, 1, 1) 

extends Node3D
class_name battle_enemy

@onready var visual := $Sprite3D
var stats: CharacterStats

func _ready():
	randomize()

	var sprites = [
		preload("res://assets/props/Enemies-BoblinTheGoblin192.png"),
		preload("res://assets/props/Enemies-BoboTheHobo192.png"),
		preload("res://assets/props/Enemies-Goblin192.png")
	]

	# Defino stats para cada enemigo
	var stats_list = [
		_create_stats(100, 20, 5, 50),  # max_hp, attack, defense, max_mana
		_create_stats(120, 15, 10, 40),
		_create_stats(80, 25, 3, 60)
	]

	var idx = randi() % sprites.size()
	visual.texture = sprites[idx]
	stats = stats_list[idx]

	stats.current_hp = stats.max_hp
	stats.current_mana = stats.max_mana

func _create_stats(max_hp: int, attack: int, defense: int, max_mana: int) -> CharacterStats:
	var s = CharacterStats.new()
	s.max_hp = max_hp
	s.attack = attack
	s.defense = defense
	s.max_mana = max_mana
	return s

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
