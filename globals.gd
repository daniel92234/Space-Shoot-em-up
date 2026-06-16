extends Node

var score = 0
var lives = 0

signal score_changed(new_score: int)

func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)

func set_score(amount: int) -> void:
	score = amount
	score_changed.emit(score)
