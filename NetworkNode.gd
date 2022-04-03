extends Sprite

onready var balance_label = $BalanceLabel
onready var firewall_label = $FirewallLabel
onready var bullet_scene := preload("res://NetworkBullet.tscn")
onready var player

var attacked : bool = false
export var is_attacker : bool = false

var balance : int
var firewall : int

func _ready() -> void:
	set_balance(2000 + randi() % 5000)
	set_firewall(100)
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
	# if this is an attacker node
	if is_attacker:
		self_modulate = Color.red
		$AttackTimer.start(1)

func attack_player():
	if player.delayer_enabled:
		return
	var bullet_instance = bullet_scene.instance()
	bullet_instance.set_collision_layer_bit(2, false)
	bullet_instance.set_collision_mask_bit(1, false)
	bullet_instance.set_collision_layer_bit(3, true)
	bullet_instance.set_collision_mask_bit(0, true)
	bullet_instance.target = player.global_position
	self.add_child(bullet_instance)
	bullet_instance.show_behind_parent = true

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
		attacked = true
		player.add_target(self)


func _on_ClickArea_area_entered(area: Area2D) -> void:
	# remove from balance based on the firewall
	var hit_value := (100 - firewall) / 4
	set_balance(balance - hit_value)
	player.set_balance(player.balance + hit_value)

	# Network bullet detected
	area.queue_free()


func _on_AttackTimer_timeout() -> void:
	if not visible:
		return
	attack_player()
