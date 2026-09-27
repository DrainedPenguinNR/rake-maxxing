extends Node2D

@onready var currencyManager = $"../CurrencyManager"
@onready var moneyDrop = preload("res://Scenes/moneydrop.tscn")
@onready var leafList = $"../LeafList"
@onready var plonk = preload("res://Scenes/plonk.tscn")

var leaf1Cost = 1
var leaf2Cost = 0
var leaf3Cost = 0
var leaf4Cost = 0
var leaf5Cost = 0




func _on_collection_area_area_entered(area: Area2D) -> void:
	var leaf = area.get_parent()
	if leaf.is_in_group("leaf1"):
		spawn_money_drop(leaf1Cost)
		currencyManager.add_money(leaf1Cost)
		leaf.queue_free()
	
	if leaf.is_in_group("leaf2"):
		spawn_money_drop(leaf2Cost)
		currencyManager.add_money(leaf2Cost)
		leaf.queue_free()
		
	if leaf.is_in_group("leaf3"):
		spawn_money_drop(leaf3Cost)
		currencyManager.add_money(leaf3Cost)
		leaf.queue_free()
	
	if leaf.is_in_group("leaf4"):
		spawn_money_drop(leaf4Cost)
		currencyManager.add_money(leaf4Cost)
		leaf.queue_free()
	
	if leaf.is_in_group("leaf5"):
		spawn_money_drop(leaf5Cost)
		currencyManager.add_money(leaf5Cost)
		leaf.queue_free()

func spawn_money_drop(value):
	var mD = moneyDrop.instantiate()
	mD.value = value
	mD.update_text()
	mD.position = Vector2(1920/2 - 50 + randi_range(-100, 100), 1080/2 - 100 + randi_range(-100, 100))
	leafList.add_child(mD)
	var pronk = plonk.instantiate()
	add_child(pronk)
	pronk.pitch_scale = randf_range(0.9, 1.1)
	pronk.play()
