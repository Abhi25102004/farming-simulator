extends State
class_name PlayerIdle

func Enter():
	if animated_sprite:
		animated_sprite.play("idle")
	else:
		print("Error: animated_sprite is null in PlayerIdle")

func Update(_delta: float):
	if Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized() != Vector2.ZERO:
		state_transition.emit(self, "Walk")
