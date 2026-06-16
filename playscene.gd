class_name PlayScene extends Node2D

@onready var camera: Camera2D = $Camera
@export var scroll_speed := 50.0

func _process(delta: float) -> void:
	global_position[1] -= scroll_speed * delta
