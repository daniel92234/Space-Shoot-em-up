extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		var attack = Attack.new()
		attack.attack = get_parent().damage
		
		area.damage(attack)
		get_parent().queue_free()
