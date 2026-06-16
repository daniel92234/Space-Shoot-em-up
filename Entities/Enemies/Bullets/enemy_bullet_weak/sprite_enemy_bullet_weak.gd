extends Sprite2D

var _spin_speed : float

func _ready():
	_spin_speed = 7.0

func _process(delta):
	rotation += _spin_speed * delta
