extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 200.0
@onready var health_component: Node = $HealthComponent
@onready var hurt_box_component: Area2D = $HurtBoxComponent
@onready var fsm: FiniteStateMachine = $Fsm
@onready var inventory_dialog: InventoryDialog = $InventoryDialog

@export var item: Item
var inventory: Inventory = Inventory.new()
var isInventoryOpen: bool = false

func _ready():
	# Initialize the FSM and pass necessary references
		# Start FSM with the initial state
	if fsm.initial_state:
		fsm.initial_state.Enter()
	# Equip initial item and add it to inventory
	var instance = item.scene.instantiate()
	add_child(instance)
	inventory.add_item(item)

func _physics_process(delta: float) -> void:
	# Delegate behavior to FSM
	fsm._process(delta)
	print(fsm.current_state)

	# Handle additional actions like inventory
	handle_inventory()

func handle_inventory():
	if Input.is_action_just_pressed("inventory_key"):
		isInventoryOpen = !isInventoryOpen
		if isInventoryOpen:
			inventory_dialog.open(inventory)
			inventory_dialog.show()
		else:
			inventory_dialog.hide()

func _on_health_component_died() -> void:
	print("Player has died.")

func _on_health_component_health_changed(current_health: int, max_health: int) -> void:
	print("Health changed: ", current_health, "/", max_health)

func _on_hurt_box_component_hit(target: Node) -> void:
	if target == health_component:
		print("Hurtbox hit the player!")
