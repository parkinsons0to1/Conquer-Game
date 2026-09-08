extends Node3D

@onready var sun: DirectionalLight3D = $SunLight
@export var day_speed: float = 0.05

func _process(delta: float) -> void:
	if sun:
		# Slowly orbit the sun to create a dynamic prehistoric day/night cycle
		sun.rotate_x(day_speed * delta * 0.1)
