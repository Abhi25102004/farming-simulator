extends Node2D
@export var damage = 10
@export var durability = 100
@export var range = 50.0

signal durability_changed(new_durability)

# Function to use the axe
func use(target):
	if durability <= 0:
		print("The axe is broken!")
		return

	if target.has_method("take_damage"):
		target.take_damage(damage)
		print("Hit target: ", target)

	if target.name == "Tree":
		target.take_damage(damage)
		print("Chopped tree!")

	# Reduce durability
	durability -= 1
	emit_signal("durability_changed", durability)
