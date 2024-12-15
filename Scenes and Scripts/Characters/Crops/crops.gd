extends Node2D

enum PlantStates{ Idle, Watering, Growing, FullGrowth }

# Variables
var Plant : PlantStates = PlantStates.Idle
var initialSprite : int = 0
var isPlayerInRange : bool = false
var elapsed_time : float = 0
var CropVarient : Crop 
@export var Name : String = "wheat"
@export var CropMap : CropVariantTable 

# Nodes
@onready var plant: Sprite2D = $Plant

func _ready() -> void:
	CropVarient = CropMap.CropTable[Name]
	elapsed_time = CropVarient.GrowthTime
	plant.texture = CropVarient.GrowthSprites[initialSprite]

func _process(delta: float) -> void:
	match Plant:
		PlantStates.Idle:
			# Placement waiting time
			elapsed_time -= delta
			if elapsed_time < 0 :
				elapsed_time = CropVarient.WaterRequire
				Plant = PlantStates.Watering
		PlantStates.Watering:
			# Player watering the crops
			if isPlayerInRange and Input.is_action_pressed("use_tool"):
				elapsed_time -= delta
				if elapsed_time < 0 :
					elapsed_time = CropVarient.GrowthTime
					Plant = PlantStates.Growing
		PlantStates.Growing:
			# Crop has been watered enough and will change to the next stage
			elapsed_time -= delta
			if elapsed_time < 0:
				elapsed_time = CropVarient.WaterRequire
				initialSprite += 1
				plant.texture = CropVarient.GrowthSprites[initialSprite]
				Plant = PlantStates.FullGrowth if initialSprite == CropVarient.GrowthSprites.size()-1 else PlantStates.Watering
		PlantStates.FullGrowth:
			# when plant is at its last stage
			if isPlayerInRange and Input.is_action_pressed("use_tool"):
				# increase the item in the inventory
				queue_free()

func WateringThePlant(area: Area2D) -> void:
	if area.get_parent().name=="Player":
		isPlayerInRange = true

func NotWateringThePlants(area: Area2D) -> void:
	if area.get_parent().name=="Player":
		isPlayerInRange = false
