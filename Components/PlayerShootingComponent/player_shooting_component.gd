class_name PlayerShootingComponent extends Node2D

@export var shooting_enabled := true
@export var selected_bullet_groups : Array[BulletGroup]

var shoot := false

func _process(_delta: float) -> void:
	for i in selected_bullet_groups:
		if shoot and shooting_enabled:
			i.shoot = true
		else:
			i.shoot = false
