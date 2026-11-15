extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const GRAVITY = 200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Tracks whether the player has touched the floor since their last jump
var can_jump: bool = false

func _physics_process(delta: float) -> void:
	# 1. Check floor state first and reset jump allowance ONLY when firmly grounded
	if is_on_floor():
		can_jump = true
	else:
		velocity.y += GRAVITY * delta

	# 2. Handle jump ONLY when grounded AND jump hasn't been used yet
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_jump:
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("Jump")
		print("played Jump")
		can_jump = false # Locks jumping until the player lands again

	# 3. Get input direction and move horizontally
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Update sprite direction and animations
	update_animations(direction)

	# 5. Apply movement (updates is_on_floor() for the next frame)
	move_and_slide()

func update_animations(direction: float) -> void:
	# Flip sprite horizontally based on movement direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play Jump when airborne, otherwise play Walking or Idle
	if not is_on_floor():
		animated_sprite.play("Idle")
	elif direction != 0:
		animated_sprite.play("Walking")


# Handle player leaving viewport
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Player left the screen! Game Over.")
	get_tree().call_deferred("reload_current_scene")
