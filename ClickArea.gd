extends Area2D

signal clicked

func _ready() -> void:
	pass


func _on_ClickArea_mouse_entered() -> void:
	$AttackLabel.visible = true

func _on_ClickArea_mouse_exited() -> void:
	$AttackLabel.visible = false

func _on_ClickArea_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if ($AttackLabel.visible and event is InputEventMouseButton and event.pressed):
		emit_signal("clicked")
