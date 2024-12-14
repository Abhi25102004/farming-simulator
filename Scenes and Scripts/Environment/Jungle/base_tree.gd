extends Node2D

@export var health:int



func take_damage(damage: int):
	health -= damage
	print("Tree health: ", health)

	if health <= 0:
		chop_down()
		
func chop_down():
	print("Tree chopped down!")
	queue_free()
