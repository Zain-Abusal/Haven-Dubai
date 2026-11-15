extends Button

func _ready() -> void:
	# Connect the button's built-in pressed signal via code
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	# Reset score to 0 so every new run starts fresh
	Global.reset_score()
	
	# Load level_1 from your root folder
	get_tree().change_scene_to_file("res://level_1.tscn")
