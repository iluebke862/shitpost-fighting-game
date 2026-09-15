extends Control

var weapon = 0
signal start()

func _on_default_pressed() -> void:
	weapon = 0
	start.emit(0)


func _on_snake_pressed() -> void:
	weapon = 1
	start.emit(1)
