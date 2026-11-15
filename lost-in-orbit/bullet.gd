extends Area2D

@export var is_spawner: bool = true 
var speed: float = 400.0
var direction: Vector2 = Vector2.LEFT

func _ready() -> void:
	# 1. Force the engine to monitor collisions and look at Layer 1
	monitoring = true
	collision_mask = 1 
	
	if is_spawner:
		var timer = Timer.new()
		timer.wait_time = 2.0
		timer.autostart = true
		timer.timeout.connect(spawn_duplicate)
		add_child(timer)
	else:
		rotation = direction.angle()

func _process(delta: float) -> void:
	if not is_spawner:
		# Move the bullet
		position += direction * speed * delta
		
		# 2. FOOLPROOF DETECTION: Check overlaps every frame
		var touched_objects = get_overlapping_bodies()
		
		for object in touched_objects:
			if object.is_in_group("player"):
				print("Direct overlap detected! Game Over.")
				get_tree().call_deferred("reload_current_scene")

func spawn_duplicate() -> void:
	var clone = self.duplicate()
	clone.is_spawner = false 
	
	# Make the main node visible
	clone.visible = true 
	
	# --- NEW: GENERATE THE SPRITE VIA CODE ---
	var new_sprite = Sprite2D.new()
	
	# Load the image (Change the .png or add folders if needed, e.g. "res://assets/57.png")
	var img_texture = load("res://57.png")
	new_sprite.texture = img_texture
	
	# Set size/scale to 1, 1
	new_sprite.scale = Vector2(1, 1)
	
	# Force it to draw over everything
	new_sprite.z_index = 100
	
	# Attach the new sprite to the cloned bullet
	clone.add_child(new_sprite)
	# -----------------------------------------
		
	add_sibling(clone)
	clone.global_position = global_position

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if not is_spawner: 
		queue_free()
