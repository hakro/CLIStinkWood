extends Sprite

signal updated_balance
signal updated_viruses
signal updated_scanners
signal updated_delayers

onready var attack_timer = $AttackTimer
onready var scan_gradient := $ScanGradient
onready var scan_tween := $ScanTween
onready var bullet_scene := preload("res://NetworkBullet.tscn")

var targets : Array = []
var firewall := 100
var balance := 1500

# Inventory
var viruses := 0
var delayers := 0
var scanners := 0

func add_target(target):
	targets.append(target)

func attack_targets():
	for target in targets:
		var bullet_instance = bullet_scene.instance()
		bullet_instance.target = target.global_position
		self.add_child(bullet_instance)
		bullet_instance.show_behind_parent = true

func scan_network():
	if scanners >= 0:
		set_scanners(scanners - 1)
		Global.display_info_message("Info: Scanning Network ...")
		scan_gradient.visible = true
		scan_tween.interpolate_property(scan_gradient,
			"scale", Vector2(0.5, 0.5), Vector2(10, 10),
			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		scan_tween.interpolate_property(scan_gradient,
			"self_modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0),
			1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		scan_tween.start()
		yield(get_tree().create_timer(1.0), "timeout")
		scan_gradient.visible = false


func _on_AttackTimer_timeout() -> void:
	attack_targets()

func set_balance(value):
	balance = value
	emit_signal("updated_balance")

func set_viruses(value):
	viruses = value
	emit_signal("updated_viruses")

func set_scanners(value):
	scanners = value
	emit_signal("updated_scanners")

func set_delayers(value):
	delayers = value
	emit_signal("updated_delayers")
