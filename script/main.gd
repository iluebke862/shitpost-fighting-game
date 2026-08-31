extends Node2D

const maps = [preload("res://map.tscn")]
const player = preload("res://player.tscn")

var active = false



func _on_button_pressed() -> void:
	get_node("map").add_child(maps.pick_random().instantiate())
	for i in 2:
		var new = player.instantiate()
		new.position = get_node("map").get_child(0).get_node("spawns").get_children()[i % get_node("map").get_child(0).get_node("spawns").get_child_count()].position
		get_node("players").add_child(new)
		new.player = i+1
	get_node("Button").hide()
	active = true

func _process(delta: float) -> void:
	if active:
		if get_node("players").get_child_count() == 0:
			get_node("map").get_child(0).queue_free()
			active = false
			get_node("Button").show()
