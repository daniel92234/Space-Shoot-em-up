extends Node2D

@export var damage := 0.0
@export var speed := 0.0
@export var direction_deg := 0.0

@onready var health_component: HealthComponent = $HealthComponent

var direction_rad: float

func _ready() -> void:
	if health_component:
		health_component.died.connect(_on_health_component_died)
	
	direction_rad = deg_to_rad(fposmod(direction_deg, 360.0))
	rotation = direction_rad

func _process(delta: float) -> void:
	var velocity = Vector2(cos(direction_rad), sin(direction_rad)) * speed * delta
	global_position += velocity

func _on_health_component_died() -> void:
	queue_free()
