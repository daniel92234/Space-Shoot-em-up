class_name PlayerMovementComponent extends Node

@export var player: Player
@export var speed := 250.0

var direction: Vector2 = Vector2.ZERO

func tick(delta: float) -> void:
	if player == null:
		return
	
	var screen_port_size = get_viewport().get_visible_rect().size
	var new_position = player.global_position + direction * speed * delta
	
	if player.playscene:
		var playscene_cam_pos = player.playscene.camera.global_position
		player.position = (new_position - Vector2(0, player.playscene.scroll_speed * delta)).clamp(playscene_cam_pos, playscene_cam_pos + screen_port_size)
	else:
		player.position = new_position.clamp(Vector2.ZERO, screen_port_size)
