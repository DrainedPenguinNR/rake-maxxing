extends Node2D

@onready var currencyManager = $"../CurrencyManager"

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F:
			currencyManager.money = 0
		elif event.keycode == KEY_F4:
			currencyManager.money += 100
