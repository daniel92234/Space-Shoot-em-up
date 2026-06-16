extends Node

@export var score := 100
@export var enabled := true

@onready var health_component: HealthComponent = $"../HealthComponent"

func _ready() -> void:
	if health_component and enabled:
		health_component.died.connect(_on_health_component_died)

func _on_health_component_died() -> void:
	Globals.add_score(score)
