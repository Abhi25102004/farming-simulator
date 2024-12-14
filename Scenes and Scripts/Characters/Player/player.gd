extends CharacterBody2D

@export var speed = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var direction = Vector2()
var using_axe=false
# Instance variable for animations
var animations = {}



@export var item:Item
var axe:Node

func _ready():
	# Initialize animations dictionary
	animations = {
		"idle": Callable(self, "handle_idle"),
		"walk": Callable(self, "handle_walk")
	}
	# Set initial animation
	set_animation("idle")
	animated_sprite.play()
	
	#Setting axe
	axe=item.scene.instantiate()
	add_child(axe)
	
	
	


func _physics_process(delta: float) -> void:
	# Handle movement and animations
	handle_movement()
	handle_animations()
	move_and_slide()



func set_animation(animation_name):
	if animation_name in animations:
		animations[animation_name].call()
	else:
		print("Animation not found: ", animation_name)

# Animation handlers



func handle_idle():
	animated_sprite.animation = "idle"
	

func handle_walk():
	animated_sprite.animation = "walk"
	animated_sprite.flip_h = direction.x < 0

# Handle animations based on current direction
func handle_animations():
	if direction == Vector2.ZERO:
		set_animation("idle")
	else:
		set_animation("walk")

# Handle movement and input
func handle_movement():
	direction = Vector2()

	# Get input direction
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
		
		
	if Input.is_action_just_pressed("use_tool"):
		using_axe=true
	

	# Normalize vector
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	velocity = direction * speed


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	
	if using_axe and area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(axe.damage)
		using_axe=false
	
func cut_tree():
	pass
