class_name DamageStateComponent extends Node

@export var flash_material: ShaderMaterial

@onready var health_component: HealthComponent = $"../HealthComponent"
@onready var low_health_flash: AnimationPlayer = $LowHealthFlash
@onready var damage_flash: AnimationPlayer = $DamageFlash
@onready var low_health_timer: Timer = $LowHealthDowntimeTimer

var low_health_active := false
var low_health_loop_running := false
var health_weight: float

func _ready():
	if health_component:
		health_component.health_change.connect(_on_health_component_health_change)
		health_component.damaged.connect(_on_health_component_damaged)	
	if low_health_timer:
		low_health_timer.timeout.connect(_on_low_health_downtime_timer_timeout)

	_apply_material(owner)

func play_damage_flash():
	damage_flash.stop()
	damage_flash.play("damage_flash")
	
func _start_low_health_flash_cycle() -> void:
	if not low_health_loop_running:
		return

	low_health_flash.play("low_health_flash")
	await low_health_flash.animation_finished

	if not low_health_loop_running:
		return

	low_health_timer.wait_time = lerp(0.04, 1.25, health_weight)
	low_health_timer.start()
	
func _on_low_health_downtime_timer_timeout() -> void:
	_start_low_health_flash_cycle()
	
func _on_health_component_health_change(_new_health: float, _amount: float) -> void:
	health_weight = clamp(inverse_lerp(0.1, 0.6, float(health_component.health) / float(health_component.max_health)), 0.0, 1.0)

	flash_material.set_shader_parameter("low_health_color", Color(1, 0.25, 0).lerp(Color(1 , 0.625,0), health_weight))
	
	if health_weight < 1.0:
		low_health_loop_running = true
		low_health_timer.stop()

		if not low_health_flash.is_playing():
			_start_low_health_flash_cycle()

func _apply_material(node: Node):
	for child in node.get_children():
		if child is Sprite2D or child is AnimatedSprite2D:
			child.material = flash_material
		_apply_material(child)

func _on_health_component_damaged() -> void:
	play_damage_flash()
