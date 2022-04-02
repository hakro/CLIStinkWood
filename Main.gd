extends Node2D

var firewall := 100
var balance := 50

onready var firewall_label := $MarginContainer/VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/FirewallBar
onready var balance_label := $MarginContainer/VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/BalanceValue

func _ready() -> void:
	firewall_label.value = 100
	balance_label.text = "$ " + String(balance)
