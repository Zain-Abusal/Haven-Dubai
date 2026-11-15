extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const Gravity = 200.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += Gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and  is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Handle player leaving viewport
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Player left the screen! Game Over.")
	get_tree().call_deferred("reload_current_scene")
