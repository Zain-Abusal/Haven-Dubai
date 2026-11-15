extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const GRAVITY = 200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var can_jump: bool = false

func _physics_process(delta: float) -> void:
	if is_on_floor():
		can_jump = true
	else:
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_jump:
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("Jump")
		can_jump = false 

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animations(direction)

	# Apply movement
	move_and_slide()

	# NEW: Check for collisions immediately after moving
	check_for_lasers()

func update_animations(direction: float) -> void:
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if not is_on_floor():
		animated_sprite.play("Idle")
	elif direction != 0:
		animated_sprite.play("Walking")

func check_for_lasers() -> void:
	# Loop through everything the player bumped into this frame
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# If the object we hit is in the laser group, trigger Game Over
		if collider and collider.is_in_group("laser"):
			trigger_game_over("Player touched a laser! Game Over.")

func trigger_game_over(message: String) -> void:
	print(message)
	get_tree().call_deferred("reload_current_scene")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	trigger_game_over("Player left the screen! Game Over.")
