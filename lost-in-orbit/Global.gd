extends Node

# Signal emitted whenever the score changes so UI updates automatically
signal score_changed(new_score: int)

var score: int = 0

func add_point(amount: int = 1) -> void:
	score += amount
	score_changed.emit(score)

func reset_score() -> void:
	score = 0
	score_changed.emit(score)
