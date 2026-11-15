extends Control

@onready var play_again_button: Button = $Button

func _ready() -> void:
	hide()
	Global.game_won.connect(_on_game_won)
	play_again_button.pressed.connect(_on_play_again_pressed)

func _on_game_won() -> void:
	show()
	get_tree().paused = true # Freezes player and moving obstacles

func _on_play_again_pressed() -> void:
	get_tree().paused = false
	Global.reset_score()
	get_tree().reload_current_scene()
