extends RigidBody2D

var HP = 1

const skins = [preload("res://sprites/derpy guy.png"),preload("res://sprites/derpy guy red.png"),preload("res://sprites/derpy guy blue.png"),preload("res://sprites/derpy guy green.png"),preload("res://sprites/derpy guy orange.png"),preload("res://sprites/derpy guy pink.png"),preload("res://sprites/derpy guy purple.png"),preload("res://sprites/derpy guy yellow.png")]


const SPEED = 50.0
const JUMP_VELOCITY = -900.0
var direction = 0
var lastdirection = 1
@export var player = 1
var inputs = [false,false,false,false]
const projectiles = [preload("res://scenes/projectile.tscn"),preload("res://scenes/snake_projectile.tscn")]
const cooldowns = [0.1,1]
var weapon = 1
var cooldown = 0
var on_floor = false
var jumpcooldown = false

signal killtracker()
	


func damage(value):
	HP += value
	if HP < 0:
		queue_free()
func apply_velocity(x,y):
	linear_velocity += Vector2(x,y) * HP


func death():
	killtracker.emit()
	queue_free()



func _physics_process(delta: float) -> void:
	get_node("Sprite2D").texture = skins[player-1]
	if cooldown > 0:
		cooldown -= delta
	get_node("RayCast2D").rotation = -rotation
	if get_node("RayCast2D").is_colliding():
		on_floor = true
	else:
		on_floor = false
		get_node("ProgressBar").text = str(HP)

	
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
	if on_floor:
		jumpcooldown = true
	if not on_floor:
		linear_velocity += get_gravity() * delta
		

	# Handle jump.
	if inputs[2]:
		inputs[2] = false
		if jumpcooldown:
			linear_velocity.y += JUMP_VELOCITY
			jumpcooldown = false
	
	if inputs[3]:
		if cooldown <= 0:
			var new = projectiles[weapon].instantiate()
			get_node("/root/main").add_child(new)
			new.position = position
			new.direction = lastdirection
			new.position += Vector2(50*new.direction,0)
			new.linear_velocity = Vector2(1000*new.direction,0)
			new.life = 3
			cooldown = cooldowns[weapon]
			inputs[3] = false


	direction = 0
	if inputs[0]:
		direction -= 1
	if inputs[1]:
		direction += 1
	if direction:
		linear_velocity += Vector2(direction * SPEED,0)
		lastdirection = direction
