class_name PlayerInputComponent extends Node

var direction: Vector2 = Vector2.ZERO
var shoot := false

func update() -> void:
	direction = Input.get_vector("Left", "Right", "Up", "Down")
	shoot = Input.is_action_pressed("Shoot")
