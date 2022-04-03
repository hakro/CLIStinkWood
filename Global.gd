extends Node

onready var info_messages
onready var player
onready var nodes : Array

var nb_scans := 0

func _ready() -> void:
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
	if get_tree().get_nodes_in_group("info_messages").size() > 0:
		info_messages = get_tree().get_nodes_in_group("info_messages")[0]
	if get_tree().get_nodes_in_group("network_nodes").size() > 0:
		nodes = get_tree().get_nodes_in_group("network_nodes")
	yield(get_tree().create_timer(3.0), "timeout")
	display_info_message("Info: Go buy a Scanner and a Virus from the Shop")

func display_info_message(text : String, timeout : float = 5.0):
	info_messages.text = text
	yield(get_tree().create_timer(timeout), "timeout")
	info_messages.text = ""

# handles adding enemies at different stages
func next_scan():
	nb_scans += 1
	match nb_scans:
		1:
			nodes[0].visible = true
			nodes[1].visible = true
			display_info_message("Info: The blue nodes do not attack you back. Use a virus to steal their money")
		2:
			nodes[2].visible = true
			nodes[3].visible = true
			display_info_message("Info: The red nodes will attack you back. Use a delayer to stop their attacks for 30s")
