extends MarginContainer

onready var player
onready var firewall_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/FirewallBar
onready var balance_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/BalanceValue
onready var scanners_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/GridTools/ScannerLabel
onready var viruses_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/GridTools/VirusLabel
onready var delayers_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/GridTools/DelayerLabel

const SCANNER_PRICE = 50
const VIRUS_PRICE = 100
const DELAYER_PRICE = 150


func _ready() -> void:
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
		firewall_label.value = player.firewall
		balance_label.text = "$ " + String(player.balance)

func _on_ShopButton_pressed() -> void:
	$Shop.visible = true

func _on_ShopCloseButton_pressed() -> void:
	$Shop.visible = false


func _on_BuyScanner_pressed() -> void:
	if player.balance >= SCANNER_PRICE:
		player.scanners += 1
		player.balance -= SCANNER_PRICE
		balance_label.text = "$ " + String(player.balance)
		scanners_label.text = "    Scanners : " + String(player.scanners)


func _on_BuyVirus_pressed() -> void:
	if player.balance >= VIRUS_PRICE:
		player.viruses += 1
		player.balance -= VIRUS_PRICE
		balance_label.text = "$ " + String(player.balance)
		viruses_label.text = "    Viruses : " + String(player.viruses)


func _on_BuyDelayer_pressed() -> void:
	if player.balance >= DELAYER_PRICE:
		player.delayers += 1
		player.balance -= DELAYER_PRICE
		balance_label.text = "$ " + String(player.balance)
		delayers_label.text = "    Delayers : " + String(player.delayers)
