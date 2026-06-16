class_name HealthComponent extends Node

@export var max_health := 100.0
@export var invincible := false

var health: float

signal health_change(new_health: float, amount: float)
signal full_heal
signal healed
signal damaged
signal died

func _ready() -> void:
	health = max_health

func damage(amount : float) -> void:
	if invincible:
		return
		
	var old_health = health
	health = clamp(health - amount, 0.0, max_health)
	
	if (old_health != health):
		health_change.emit(health, health - old_health)
		damaged.emit()
		if health == 0.0:
			died.emit()

func heal(amount : float) -> void:
	var old_health = health
	health = clamp(health + amount, 0.0, max_health)
	
	if old_health != health:
		health_change.emit(health, health - old_health)
		healed.emit()
		if health == max_health:
			full_heal.emit()

func set_health(amount : float) -> void:
	var old_health = health
	health = clamp(amount, 0.0, max_health)
	
	if (old_health > health):
		damaged.emit()
	if (old_health < health):
		healed.emit()
	
	if (old_health != health):
		health_change.emit(health, health - old_health)
		if health == 0.0:
			died.emit()
		if health == max_health:
			full_heal.emit()
