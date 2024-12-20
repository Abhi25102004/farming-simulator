extends State
class_name PlayerAxe

@export var axe_action_duration: float = 0.5  # Duration of the axe action in seconds
@onready var timer: Timer = $Timer

func Enter():
	if animated_sprite:
		animated_sprite.play("axe")
	else:
		print("Error: animated_sprite is null in PlayerAxe")
	timer.wait_time=axe_action_duration
	timer.start()

	# Optionally, play a sound effect or trigger any logic related to the axe action
	_perform_axe_action()

func _perform_axe_action():
	print("Performing axe action...")

func Update(_delta: float):
	pass

func Exit():
	pass


func check_dir(dir: Vector2):
	if dir.x > 0:
		# Moving right
		animated_sprite.flip_h = false
	elif dir.x < 0:
		# Moving left
		animated_sprite.flip_h = true


func _on_timer_timeout() -> void:
	state_transition.emit(self, "Idle")
