@tool
class_name HitboxPlayerCollisionComponent extends Area2D

@export var damage := 100.0
@export var damage_received := 100.0
@export var death_on_collision := true:
	set(val):
		death_on_collision = val
		notify_property_list_changed()

@onready var health_component: HealthComponent = $"../HealthComponent"

signal player_ship_collide

func _validate_property(property: Dictionary) -> void:
	if property.name == "damage" and not death_on_collision:
		property.usage |= PROPERTY_USAGE_READ_ONLY
	if property.name == "damage_received" and death_on_collision:
		property.usage |= PROPERTY_USAGE_READ_ONLY

func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)
		return
	else:
		area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		player_ship_collide.emit()
		
		var attack = Attack.new()
		if death_on_collision == true:
			attack.attack = damage
		else:
			attack.attack = 100.0
		area.damage(attack)
		
		if death_on_collision:
			health_component.set_health(0.0)
		else:
			health_component.damage(damage_received)
