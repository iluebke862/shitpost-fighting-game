extends RigidBody2D
var direction = 1
var life = 0


func _physics_process(delta: float) -> void:
	life -= delta
	if life < 0:
		queue_free()
	for i in get_colliding_bodies():
		if i.is_in_group("Players"):
			i.damage(10)
			i.apply_velocity(randf()*10-5,randf()*10-5) 
			linear_velocity += Vector2(randf()*1000-5,randf()*1000-5)
