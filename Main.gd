extends MarginContainer

# Player stats
var firewall := 100
var balance := 50

onready var firewall_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/FirewallBar
onready var balance_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/BalanceValue

func _ready() -> void:
	firewall_label.value = 100
	balance_label.text = "$ " + String(balance)

