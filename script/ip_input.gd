extends TextEdit
var lastText = ""
const digList = ["0","1","2","3","4","5","6","7","8","9","."]
const mainNode = preload("res://scenes/main.tscn")
signal conectionPF
var connectionPFV = false

func _on_text_changed() -> void:
	for i in text:
		if !i in digList:
			text = lastText


func _on_join_pressed() -> void:
	if visible:
		if text.is_valid_ip_address():
			var preloaded = mainNode.instantiate()
			var peer = ENetMultiplayerPeer.new()
			preloaded.passedData = get_parent().get_parent().get_node("Customization").selections
			get_parent().get_parent().get_parent().get_parent().add_child(preloaded)
			var output = peer.create_client(text,9000)
			preloaded.multiplayer.multiplayer_peer = peer
			if output == 0:
				preloaded.multiplayer.connected_to_server.connect(yes)
				await conectionPF
				if connectionPFV:
					print("success conenct")
					get_parent().get_parent().get_parent().queue_free()
				else:
					text = "Connection Failed"
			else:
				text = error_string(output)
		else:
			text = "INVALID IP"
	else:
		show()

func yes():
	connectionPFV = true
	conectionPF.emit()
func no():
	connectionPFV = false
	conectionPF.emit()

func _on_host_pressed() -> void:
	var host = ENetMultiplayerPeer.new()
	var output = host.create_server(9000)
	if output == 0:
		var preloaded = mainNode.instantiate()
		preloaded.passedData = get_parent().get_parent().get_node("Customization").selections
		get_parent().get_parent().get_parent().get_parent().add_child(preloaded)
		preloaded.multiplayer.multiplayer_peer = host
		get_parent().get_parent().get_parent().queue_free()
		
	else:
		print(error_string(output))
	
