extends Node3D
class_name battle_player

signal health_changed(current, max)
signal mana_changed(current, max)

@export var stats: CharacterStats
@export var inv: Inv
@export var abilities: Array[Ability]

func _ready() -> void:
	stats.current_mana = stats.max_mana

func attack(target: Node):
	var damage = stats.attack - target.stats.defense
	damage = max(damage, 0)
	target.receive_damage(damage)

func receive_damage(amount: int):
	stats.current_hp -= amount
	print("Jugador recibió ", amount, " de daño. HP actual: ", stats.current_hp, " Maná actual: ", stats.current_mana)
	emit_signal("health_changed", stats.current_hp, stats.max_hp)
	
	PlayerEstado.current_hp = stats.current_hp
	PlayerEstado.max_hp = stats.max_hp


func heal(amount: int):
	stats.current_hp += amount
	stats.current_hp = clamp(stats.current_hp, 0, stats.max_hp)
	emit_signal("health_changed", stats.current_hp, stats.max_hp)
	
	PlayerEstado.current_hp = stats.current_hp
	PlayerEstado.max_hp = stats.max_hp


func restore_mana(amount: int):
	stats.current_mana += amount
	stats.current_mana = clamp(stats.current_mana, 0, stats.max_mana)
	emit_signal("mana_changed", stats.current_mana, stats.max_mana)
	
	PlayerEstado.current_mana = stats.current_mana
	PlayerEstado.max_mana = stats.max_mana


func use_ability(index: int, target: Node):
	if index >= abilities.size():
		print("Habilidad inválida")
		return
	var ability = abilities[index]
	if stats.current_mana >= ability.mana_cost:
		stats.current_mana -= ability.mana_cost
		emit_signal("mana_changed", stats.current_mana, stats.max_mana)
		target.receive_damage(ability.damage)
		heal(ability.healing)
		print("Usaste la habilidad: ", ability.name, " e hiciste ", ability.damage, " de daño.")
		print("Recuperaste: ", ability.healing, " HP.")
		
		var bloodbite_scene = get_tree().get_root().get_node("battlescene_UI/BloodBite")
		var audio_player = bloodbite_scene.get_node_or_null("AudioStreamPlayer")
		if bloodbite_scene:
			var anim_sprite = bloodbite_scene.get_node_or_null("AnimatedSprite2D")
			anim_sprite.play("default")
		if audio_player:
				audio_player.play()
		else:
			print("No se encontró bloodbite en la escena.")
	else:
		print("No hay suficiente maná para usar ", ability.name)
