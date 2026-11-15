extends Label

func _ready() -> void:
	# Set the initial score text on load
	text = "Score: " + str(Global.score)
	
	# Automatically update the text whenever Global.add_point() runs
	Global.score_changed.connect(_on_score_changed)

func _on_score_changed(new_score: int) -> void:
	text = "Score: " + str(new_score)
