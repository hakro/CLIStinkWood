extends Area2D

var target := Vector2()
var speed := 30
var vel : Vector2

func _ready() -> void:
	vel = (target - global_position).normalized()

func _physics_process(_delta: float) -> void:
	position += vel * speed
