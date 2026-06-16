class_name HurtboxComponent extends Area2D

@onready var health_component: HealthComponent = $"../HealthComponent"

func damage(attack: Attack) -> void:
	if health_component:
		health_component.damage(attack.attack)
