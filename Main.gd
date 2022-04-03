extends MarginContainer

onready var player
onready var firewall_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/FirewallBar
onready var balance_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/BalanceValue

func _ready() -> void:
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
		firewall_label.value = player.firewall
		balance_label.text = "$ " + String(player.balance)

