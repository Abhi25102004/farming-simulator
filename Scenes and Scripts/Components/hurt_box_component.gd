extends Area2D

@export var damage: int = 10
@export var knockback: Vector2 = Vector2.ZERO
@export var is_active: bool = true # Whether the HurtBox is active or not
@export var health_component: HealthComponent 

signal hit(target: Node) # Signal emitted when the HurtBox hits a valid target


func _on_area_entered(area: Area2D) -> void:
	

	if not is_active or health_component == null:
		return


	health_component.take_damage(damage)
	emit_signal("hit", health_component)
		
