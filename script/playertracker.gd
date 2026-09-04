extends Control

var player

@onready var Sprite = $Sprite
@onready var Name = $Name
@onready var Health = $Health

const textures = [
	preload("res://sprites/derpy guy.png"),
	preload("res://sprites/derpy guy red.png")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Name.text = "Player "+ str(player.player)
	Sprite.texture = textures[player.player-1]
	player.killtracker.connect(die)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Health.text = str(player.HP)
	pass

func die():
	queue_free()
