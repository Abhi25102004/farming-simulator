class_name InventoryDialog
extends PanelContainer
@export var slot_scene:PackedScene
@onready var grid_container: GridContainer = %GridContainer

func _on_close_button_pressed() -> void:
	hide()
	

func _ready() -> void:
	print("Opened Inventory")

func open(inventory:Inventory):
	show()
	
	
	for child in grid_container.get_children():
		child.queue_free()
	for item in inventory.get_items():
		var slot=slot_scene.instantiate()
		grid_container.add_child(slot)
		slot.display_icon(item)
		
