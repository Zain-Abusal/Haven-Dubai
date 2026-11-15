extends Area2D

@export var min_respawn_time: float = 4.0
@export var max_respawn_time: float = 5.5

var is_collected: bool = false

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Ignore if already collected or if touched by floors/walls
	if is_collected or not (body is CharacterBody2D):
		return

	# 1. Lock collection and add score
	is_collected = true
	Global.add_point(1)

	# 2. Hide the shard and disable collision safely using set_deferred
	visible = false
	set_deferred("monitoring", false)

	# 3. Wait a random time between 3 and 4 seconds
	var wait_time := randf_range(min_respawn_time, max_respawn_time)
	await get_tree().create_timer(wait_time).timeout

	# 4. Make the shard reappear and re-enable collision
	visible = true
	monitoring = true
	is_collected = false
