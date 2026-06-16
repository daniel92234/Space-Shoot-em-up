class_name Player extends Node2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var player_input_component: PlayerInputComponent = $PlayerInputComponent
@onready var player_movement_component: PlayerMovementComponent = $PlayerMovementComponent
@onready var player_shooting_component: PlayerShootingComponent = $PlayerShootingComponent
@onready var playscene: PlayScene = get_node_or_null("../PlayScene")

func _process(delta: float) -> void:
	
	player_input_component.update()
	player_shooting_component.shoot = player_input_component.shoot
	player_movement_component.direction = player_input_component.direction
	player_movement_component.tick(delta)
