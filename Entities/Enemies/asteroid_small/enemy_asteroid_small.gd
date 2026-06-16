extends Node2D

@export var speed := 0.0
@export_range(0.0, 360.0) var direction_deg := 90.0
@export var explosion: PackedScene

@onready var health_component: HealthComponent = $HealthComponent
@onready var screen_visible_component: ScreenVisibleComponent = $ScreenVisibleComponent
@onready var particles_node: Node = get_node_or_null(^"../../Particles")

var _direction_rad: float

func _ready() -> void:
	if health_component:
		health_component.died.connect(_on_health_component_died)

func _process(delta: float) -> void:
	direction_deg = fposmod(direction_deg, 360.0)
	_direction_rad = deg_to_rad(direction_deg)
	var velocity = Vector2(cos(_direction_rad), sin(_direction_rad)) * speed * delta
	
	if screen_visible_component.entered_screen:
		$HurtboxComponent.monitorable = true
		$HitboxPlayerCollisionComponent.monitoring = true
		global_position += velocity
	else:
		$HurtboxComponent.monitorable = false
		$HitboxPlayerCollisionComponent.monitoring = false

func _on_health_component_died() -> void:
	if particles_node and explosion:
		var die_explosion = explosion.instantiate()
		die_explosion.global_position = global_position
		particles_node.add_child(die_explosion)
	else:
		push_warning("Explosion could not be spawned: packed particle scene not selected or missing explosion particle node in root node.")
	
	queue_free()
