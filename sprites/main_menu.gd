extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("HBoxContainer/VBoxContainer/Host").hide()
	get_node("HBoxContainer/VBoxContainer/Join").hide()
	get_node("HBoxContainer/VBoxContainer/ip_input").hide()


func _on_play_pressed() -> void:
	get_node("HBoxContainer/VBoxContainer/Host").show()
	get_node("HBoxContainer/VBoxContainer/Join").show()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		get_node("HBoxContainer/VBoxContainer/Host").hide()
		get_node("HBoxContainer/VBoxContainer/Join").hide()
		get_node("HBoxContainer/VBoxContainer/ip_input").hide()
