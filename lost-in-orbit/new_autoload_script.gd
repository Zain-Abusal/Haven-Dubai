extends CanvasLayer

var overlay: ColorRect
var title_label: Label
var play_again_button: Button

func _ready() -> void:
	# Keep UI interactive even if the game pauses
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 100 # Ensures it renders on top of all other UI
	
	# Build the UI elements via code and hide initially
	_build_win_ui()
	hide()

	# Listen for the 20-point win signal
	Global.game_won.connect(_on_game_won)

func _build_win_ui() -> void:
	# 1. Full-screen semi-transparent dark background
	overlay = ColorRect.new()
	overlay.color = Color(0.05, 0.05, 0.1, 0.85) # Dark blue-black tint
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(overlay)

	# 2. Centered container to stack text and button cleanly
	var center_box := CenterContainer.new()
	center_box.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.add_child(center_box)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 24)
	center_box.add_child(vbox)

	# 3. Large Gold "YOU WIN!" Label
	title_label = Label.new()
	title_label.text = "YOU WIN!"
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 56)
	title_label.add_theme_color_override("font_color", Color(1.0, 0.84, 0.0)) # Gold
	title_label.add_theme_color_override("font_outline_color", Color.BLACK)
	title_label.add_theme_constant_override("outline_size", 6)
	vbox.add_child(title_label)

	# 4. Styled "Play Again" Button
	play_again_button = Button.new()
	play_again_button.text = "Play Again"
	play_again_button.custom_minimum_size = Vector2(220, 55)
	play_again_button.add_theme_font_size_override("font_size", 26)
	play_again_button.pressed.connect(_on_play_again_pressed)
	vbox.add_child(play_again_button)

func _on_game_won() -> void:
	title_label.text = "YOU WIN!\nFinal Score: " + str(Global.score)
	show()
	get_tree().paused = true

func _on_play_again_pressed() -> void:
	get_tree().paused = false
	Global.reset_score()
	get_tree().reload_current_scene()
