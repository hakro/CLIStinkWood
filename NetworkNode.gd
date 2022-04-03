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
	if not attacked:
		print("player attacked node")
		attacked = true
		player.add_target(self)


func _on_ClickArea_area_entered(area: Area2D) -> void:
	# Network bullet detected
	area.queue_free()
