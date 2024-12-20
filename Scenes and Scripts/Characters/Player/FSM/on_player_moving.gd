extends State
class_name PlayerMove
@export var speed: float = 200.0

func Enter():
	if animated_sprite:
		animated_sprite.play("walk")
		
	else:
		print("Error: animated_sprite is null in PlayerMove")

func Update(_delta: float):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	check_dir(input_dir)
	Move(input_dir)


func Exit():
	pass


func Move(input_dir: Vector2):
	if animated_sprite and input_dir == Vector2.ZERO:
		state_transition.emit(self, "Idle")
	else:
		
		get_parent().get_parent().velocity = input_dir * speed
		get_parent().get_parent().move_and_slide()

func check_dir(dir:Vector2):
	if dir.x > 0:
		# Moving right
		animated_sprite.flip_h = false
	elif dir.x < 0:
		# Moving left
		animated_sprite.flip_h = true
