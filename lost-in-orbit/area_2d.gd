extends Area2D

@export var min_respawn_time: float = 3.8
@export var max_respawn_time: float = 5.0

var is_collected: bool = false

func _ready() -> void:
	
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	#ignore if already collected or if touched by floor/wall
	if is_collected or not (body is CharacterBody2D):
		return

	is_collected = true
	Global.add_point(1)

	visible = false
	set_deferred("monitoring", false)

	var wait_time := randf_range(min_respawn_time, max_respawn_time)
	await get_tree().create_timer(wait_time).timeout

	# 4. Make the shard reappear and re-enable collision
	visible = true
	monitoring = true
	is_collected = false
