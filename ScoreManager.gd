extends Node

signal score_changed(new_score: int)

var score := 0

func add_points(amount: int) -> void:
	score += amount
	emit_signal("score_changed", score)

func reset_score() -> void:
	score = 0
	emit_signal("score_changed", score)

func get_score() -> int:
	return score
