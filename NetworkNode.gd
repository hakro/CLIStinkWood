extends Sprite

onready var balance_label = $BalanceLabel
onready var firewall_label = $FirewallLabel
onready var player

var attacked : bool = false

var balance : int
var firewall : int

func _ready() -> void:
	set_balance(5000)
	set_firewall(100)
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]

func set_balance(value: int):
	balance = value
	balance_label.text = "Balance: $" + String(balance)

func set_firewall(value: int):
	firewall = value
	firewall_label.text = "Firewall: %" + String(firewall)


func _on_ClickArea_clicked() -> void:
	if player.viruses <= 0:
		Global.display_info_message("Info: You need to buy viruses from the Shop to attack")
		return
	if firewall > 10:
		set_firewall(firewall - 10)

	player.set_viruses(player.viruses - 1)
	if not attacked:
		print("player attacked node")
		attacked = true
		player.add_target(self)


func _on_ClickArea_area_entered(area: Area2D) -> void:
	# remove from balance based on the firewall
	var hit_value := (100 - firewall) / 10
	set_balance(balance - hit_value)
	player.set_balance(player.balance + hit_value)

	# Network bullet detected
	area.queue_free()
