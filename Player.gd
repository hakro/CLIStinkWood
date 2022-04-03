extends Sprite

onready var attack_timer = $AttackTimer
onready var bullet_scene := preload("res://NetworkBullet.tscn")

var targets : Array = []
var firewall := 100
var balance := 500

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


func _on_AttackTimer_timeout() -> void:
	attack_targets()
