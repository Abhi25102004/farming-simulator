extends Node2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: Area2D = $HurtBoxComponent



func _ready():
	health_component.take_damage(30)

	_on_hurt_box_component_hit(health_component)

func _on_hurt_box_component_hit(target: Node) -> void:
	print(target)
	
	



func _on_health_component_died() -> void:
	pass # Replace with function body.
	
	



func _on_health_component_health_changed(current_health: int, max_health: int) -> void:
	pass # Replace with function body.
