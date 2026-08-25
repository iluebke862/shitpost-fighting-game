extends RigidBody2D
var direction = 1

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	linear_velocity = Vector2(1000*direction,0)
