extends CharacterBody2D

var HP = 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = 0
var lastdirection = 1
@export var player = 1
var inputs = [false,false,false,false]
const projectile = preload("res://projectile.tscn")

func _physics_process(delta: float) -> void:
	if HP < 0:
		queue_free()
	
	if player == 1:
		if Input.is_action_pressed("P1 - left"):
			inputs[0] = true
		else:
			inputs[0] = false
		if Input.is_action_pressed("P1 - right"):
			inputs[1] = true
		else:
			inputs[1] = false
		if Input.is_action_just_pressed("P1 - jump"):
			inputs[2] = true
		if Input.is_action_just_pressed("P1 - shoot"):
			inputs[3] = true
	elif player == 2:
		if Input.is_action_pressed("P2 - left"):
			inputs[0] = true
		else:
			inputs[0] = false
		if Input.is_action_pressed("P2 - right"):
			inputs[1] = true
		else:
			inputs[1] = false
		if Input.is_action_just_pressed("P2 - jump"):
			inputs[2] = true
		if Input.is_action_just_pressed("P2 - shoot"):
			inputs[3] = true
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if inputs[2]:
		inputs[2] = false
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
	
	if inputs[3]:
		var new = projectile.instantiate()
		get_node("/root/main").add_child(new)
		new.position = position
		new.direction = lastdirection
		new.position += Vector2(10*new.direction,0)
		
		inputs[3] = false


	direction = 0
	if inputs[0]:
		direction -= 1
	if inputs[1]:
		direction += 1
	if direction:
		velocity.x = direction * SPEED
		lastdirection = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
