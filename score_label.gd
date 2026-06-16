extends Label

func _ready() -> void:
	Globals.score_changed.connect(_on_score_changed)
	text = "Score: %d" % Globals.score

func _on_score_changed(new_score: int) -> void:
	text = "Score: %d" % new_score
