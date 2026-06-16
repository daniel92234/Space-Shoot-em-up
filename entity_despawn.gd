extends Area2D

func _ready() -> void:
	area_entered.connect(func(area: Area2D) -> void:
		area.get_parent().queue_free()
	)
