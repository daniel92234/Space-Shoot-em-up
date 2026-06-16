extends Sprite2D

@onready var _screen_visible_component: ScreenVisibleComponent = $"../ScreenVisibleComponent"

var _spin_speed : float

func _ready():
	_spin_speed = randf_range(-3.0, 3.0)

func _process(delta):
	if _screen_visible_component.on_screen:
		rotation += _spin_speed * delta
