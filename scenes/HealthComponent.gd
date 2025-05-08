extends Node

class_name HealthComponent

# Señala cuando cambia o muere
signal health_changed(current_health, max_health)
signal died

# Variables
@export var max_health: int = 100
var current_health: int = max_health

# Sacarlo al inspector por si acaso
@export var health_bar: ProgressBar

func _ready():
	current_health = max_health
	_update_health_bar()

func take_damage(amount: int):
	current_health = max(current_health - amount, 0)
	emit_signal("health_changed", current_health, max_health)
	_update_health_bar()

	if current_health <= 0:
		emit_signal("died")

func heal(amount: int):
	current_health = min(current_health + amount, max_health)
	emit_signal("health_changed", current_health, max_health)
	_update_health_bar()

func _update_health_bar():
	if health_bar:
		health_bar.value = current_health
		health_bar.max_value = max_health
