extends Label

func _ready() -> void:
	# Keep this Label active while the rest of the game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	Global.game_won.connect(_on_game_won)

func _on_game_won() -> void:
	show()
	
	# Freeze the entire game
	get_tree().paused = true
	
	# Pass "true" for process_always so the timer keeps ticking while paused!
	for seconds_left in range(5, 0, -1):
		text = "You Win!\nReturning in " + str(seconds_left) + "..."
		await get_tree().create_timer(1.0, true).timeout
	
	# Unpause, reset score, and load main_menu
	get_tree().paused = false
	Global.reset_score()
	get_tree().change_scene_to_file("res://main_menu.tscn")
