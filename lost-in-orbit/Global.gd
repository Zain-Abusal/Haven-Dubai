extends Node

signal score_changed(new_score: int)
signal game_won

var score: int = 0
var has_won: bool = false

func add_point(amount: int = 1) -> void:
	if has_won:
		return

	score += amount
	score_changed.emit(score)

	if score >= 1:
		has_won = true
		game_won.emit()

func reset_score() -> void:
	score = 0
	has_won = false
	score_changed.emit(score)
