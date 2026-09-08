extends CanvasLayer

@onready var player: CharacterBody3D = get_parent()
@onready var health_bar: ProgressBar = $VitalsContainer/HealthBar
@onready var stamina_bar: ProgressBar = $VitalsContainer/StaminaBar
@onready var hunger_bar: ProgressBar = $VitalsContainer/HungerBar

func _process(_delta: float) -> void:
	if player:
		if health_bar:
			health_bar.value = player.health
		if stamina_bar:
			stamina_bar.value = player.stamina
		if hunger_bar:
			hunger_bar.value = player.hunger
