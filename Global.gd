extends Node

onready var info_messages
var nb_scans := 0

func _ready() -> void:
	if get_tree().get_nodes_in_group("info_messages").size() > 0:
		info_messages = get_tree().get_nodes_in_group("info_messages")[0]
	yield(get_tree().create_timer(3.0), "timeout")
	display_info_message("Info: Go buy a Scanner and a Virus from the Shop")

func display_info_message(text : String, timeout : float = 5.0):
	info_messages.text = text
	yield(get_tree().create_timer(timeout), "timeout")
	info_messages.text = ""
