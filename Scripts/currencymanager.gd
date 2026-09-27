extends Node2D

var money = 0
@onready var counter = $"../MoneyCounter"

func _process(delta: float) -> void:
	counter.text = "Money: $" + str(money)

func add_money(amount):
	money += amount

func remove_money(amount):
	money -= amount
