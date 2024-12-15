extends Node
@export var max_health: int = 100
var current_health: int

signal health_changed(current_health: int, max_health: int)
signal died()

func _ready() -> void:
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	#Ensures the health never goes less than 0 or more than max health
	current_health = clamp(current_health, 0, max_health)
	emit_signal("health_changed", current_health, max_health)
	if current_health <= 0:
		emit_signal("died")
		

func heal(amount: int):
	#heal the current hp
	current_health += amount
	current_health = clamp(current_health, 0, max_health)
	emit_signal("health_changed", current_health, max_health)

func is_alive():
	return current_health > 0

func reset_health() -> void:
	current_health = max_health
	emit_signal("health_changed", current_health, max_health)
