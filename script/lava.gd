extends Area2D

var playersin = []


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Projectiles"):
		print(body)
		body.queue_free()
	if body.is_in_group("Players"):
		playersin.append(body)
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Players"):
		playersin.erase(body)

func _physics_process(delta: float) -> void:
	for i in playersin:
		i.apply_velocity(0,-1)
		i.damage(1)
		i.jumpcooldown = true
