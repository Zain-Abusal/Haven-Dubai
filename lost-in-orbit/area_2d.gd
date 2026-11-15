extends Area2D

func _ready() -> void:
	# Connect the built-in body_entered signal via code
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Only trigger when the Player touches the shard (not floors or walls!)
	if body is CharacterBody2D or body.is_in_group("player"):
		Global.add_point(1)
		queue_free() # Deletes the shard from the scene
