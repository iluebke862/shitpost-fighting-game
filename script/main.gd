extends Node2D

const maps = [preload("res://scenes/map.tscn")]
const player = preload("res://scenes/player.tscn")
const tracker = preload("res://scenes/playertracker.tscn")

var connectedPlayers = 0
var passedData

var active = false

func _ready() -> void:
	player_join.rpc(passedData)
	print("hoi")
	#await multiplayer.peer_connected
	startgame()

func startgame():
	print(multiplayer.multiplayer_peer)
	load_map.rpc(maps.pick_random().instantiate())
	active = true

func _on_button_pressed() -> void:
	get_node("play button").hide()

	


#func _process(delta: float) -> void:
	#if active:
		#if get_node("players").get_child_count() == 0:
			#get_node("map").get_child(0).queue_free()
			#active = false
			#get_node("play button").show()


@rpc
func load_map(map):
	get_node("map").add_child(map)

@rpc
func player_join(data):
	print(data)
	var new = player.instantiate()
	new.position = get_node("map").get_child(0).get_node("spawns").get_children()[connectedPlayers % get_node("map").get_child(0).get_node("spawns").get_child_count()].position
	get_node("players").add_child(new)
	new.player = multiplayer.get_unique_id()
	var newtracker = tracker.instantiate()
	newtracker.player = new
	get_node("player list/HBoxContainer").add_child(newtracker)
	new.weapon = passedData["weapon"]
