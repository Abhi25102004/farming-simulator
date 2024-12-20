extends State
class_name PlayerIdle
var direction:Vector2
func Enter():
	if animated_sprite:
		animated_sprite.play("idle")
	else:
		print("Error: animated_sprite is null in PlayerIdle")

func Update(_delta: float):
	direction=Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	check_dir(direction)
	if direction != Vector2.ZERO:
		state_transition.emit(self, "Walk")
		
	if Input.is_action_just_pressed("use_tool"):
		state_transition.emit(self,"Axe")
		
		
		
func check_dir(dir:Vector2):
	if dir.x > 0:
		# Moving right
		animated_sprite.flip_h = false
	elif dir.x < 0:
		# Moving left
		animated_sprite.flip_h = true
