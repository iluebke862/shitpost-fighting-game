extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players") or body.is_in_group("Projectiles"):
		body.queue_free()
