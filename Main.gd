extends MarginContainer

onready var player
onready var firewall_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/FirewallBar
onready var balance_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/BalanceValue
onready var scanners_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/GridTools/ScannerLabel
onready var viruses_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/GridTools/VirusLabel
onready var delayers_label := $VBoxContainer/HBoxContainer/HSplitContainer/LeftSplit/MarginContainer/VBoxContainer/Stats/GridTools/DelayerLabel
onready var click_player := $ClickAudio
onready var bg_music := $BackgroundMusicAudio

const SCANNER_PRICE = 30
const VIRUS_PRICE = 20
const DELAYER_PRICE = 80

func _ready() -> void:
	Global._ready()
	click_player.play()
	bg_music.play()
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
		firewall_label.value = player.firewall
		balance_label.text = "$ " + String(player.balance)
		player.connect("updated_firewall", self, "update_firewall_display")
		player.connect("updated_balance", self, "update_balance_display")
		player.connect("updated_viruses", self, "update_viruses_display")
		player.connect("updated_delayers", self, "update_delayers_display")
		player.connect("updated_scanners", self, "update_scanners_display")
		player.connect("game_over", self, "game_over")

func _on_ShopButton_pressed() -> void:
	$Shop.visible = true
	click_player.set_pitch_scale(0.95)
	click_player.play()

func _on_ShopCloseButton_pressed() -> void:
	$Shop.visible = false
	click_player.set_pitch_scale(1.01)
	click_player.play()

func _on_BuyScanner_pressed() -> void:
	if player.balance >= SCANNER_PRICE:
		player.scanners += 1
		player.balance -= SCANNER_PRICE
		balance_label.text = "$ " + String(player.balance)
		scanners_label.text = "    Scanners : " + String(player.scanners)
		click_player.set_pitch_scale(1.1)
		click_player.play()

func _on_BuyVirus_pressed() -> void:
	if player.balance >= VIRUS_PRICE:
		player.viruses += 1
		player.balance -= VIRUS_PRICE
		balance_label.text = "$ " + String(player.balance)
		viruses_label.text = "    Viruses : " + String(player.viruses)
		click_player.set_pitch_scale(0.95)
		click_player.play()


func _on_BuyDelayer_pressed() -> void:
	click_player.play()
	if player.balance >= DELAYER_PRICE:
		player.delayers += 1
		player.balance -= DELAYER_PRICE
		balance_label.text = "$ " + String(player.balance)
		delayers_label.text = "    Delayers : " + String(player.delayers)
		click_player.set_pitch_scale(0.98)
		click_player.play()

func update_firewall_display():
	firewall_label.value = player.firewall

func update_balance_display():
	balance_label.text = "$ " + String(player.balance)

func update_viruses_display():
	viruses_label.text = "    Viruses : " + String(player.viruses)

func update_delayers_display():
	delayers_label.text = "    Delayers : " + String(player.delayers)

func update_scanners_display():
	scanners_label.text = "    Scanners : " + String(player.scanners)

func _on_VirusButton_pressed() -> void:
	#click_player.play()
	if player.viruses <= 0:
		Global.display_info_message("Info: You need to buy viruses from the Shop to attack network nodes")
		return

	Global.display_info_message("Info: Click on a detected network node to attack it")

func _on_DelayerButton_pressed() -> void:
	click_player.play()
	if player.delayers <= 0:
		Global.display_info_message("Info: You need to buy delayers from the Shop to defend yourself")
		return
	player.enable_delayer()

func _on_ScannerButton_pressed() -> void:
	click_player.play()
	if player.scanners <= 0:
		Global.display_info_message("Info: You need to buy scanners from the Shop to scan the network for victims")
		return
	player.scan_network()


func _on_RestartButton_pressed() -> void:
	click_player.play()
	get_tree().reload_current_scene()

func game_over():
	$GameOver.visible = true


func _on_MusicButton_pressed() -> void:
	bg_music.playing = not bg_music.playing
