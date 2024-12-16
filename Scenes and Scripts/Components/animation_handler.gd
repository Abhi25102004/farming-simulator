extends Node2D

@export var animated_sprite: AnimatedSprite2D
var animations = {}
var current_animation: String = "idle"  

func initialize_animations(animations_dict: Dictionary) -> void:
	animations = animations_dict
	set_animation("idle")


func set_animation(animation_name: String) -> void:
	if animation_name in animations:
		animations[animation_name].call()
		current_animation = animation_name
	else:
		print("Animation not found: ", animation_name)


func handle_idle() -> void:
	animated_sprite.animation = "idle"

func handle_walk() -> void:
	animated_sprite.animation = "walk"

func handle_attack() -> void:
	animated_sprite.animation = "attack"
