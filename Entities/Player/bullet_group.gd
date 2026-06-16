class_name BulletGroup extends Node2D

@export var bullet_spawns: Array[BulletSpawn]
@export var timer: Timer

var shoot := false
var can_shoot := true

func _process(_delta: float) -> void:
	var bullets_node = get_node_or_null("../../../PlayerBullets")
	var play_scene: PlayScene = get_node_or_null("../../../PlayScene")
	
	if shoot and can_shoot:
		if bullets_node:
			for i in bullet_spawns:
				var bullet = i.bullet.instantiate()
				bullet.global_position = i.global_position
				if play_scene:
					bullet.speed = i.speed + play_scene.scroll_speed
				else:
					bullet.speed = i.speed
				bullet.direction_deg = i.direction_deg
				bullets_node.add_child(bullet)
		else:
			push_warning("Bullet could not be spawned: missing bullet node in root node.")
	
		can_shoot = false
		timer.start()

func _on_timer_timeout() -> void:
	can_shoot = true
