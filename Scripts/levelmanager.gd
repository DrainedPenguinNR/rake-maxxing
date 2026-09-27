extends Node2D

@onready var currencyManager = $"../CurrencyManager"
@onready var chute = $"../Chute"
@onready var spawnManager = $"../SpawnManager"
@onready var SaveManager = $"../SaveManager"

var leaf1Values = {
	"id": 1,
	"level": 1,
	"max level": 10,
	"current price": 10,
	"base price": 10,
	"base value": 1,
	"price growth rate": 1.585,
	"value growth rate": 1.45,
	"base weight": 100,
	"weight growth rate": 1
}

var leaf2Values = {
	"id": 2,
	"level": 0,
	"max level": 10,
	"current price": 75,
	"base price": 75,
	"base value": 6,
	"price growth rate": 1.6,
	"value growth rate": 1.5,
	"base weight": 5,
	"weight growth rate": 1.395
}

var leaf3Values = {
	"id": 3,
	"level": 0,
	"max level": 10,
	"current price": 500,
	"base price": 500,
	"base value": 40,
	"price growth rate": 1.62,
	"value growth rate": 1.55,
	"base weight": 5,
	"weight growth rate": 1.395
}

var leaf4Values = {
	"id": 4,
	"level": 0,
	"max level": 10,
	"current price": 3500,
	"base price": 3500,
	"base value": 250,
	"price growth rate": 1.65,
	"value growth rate": 1.6,
	"base weight": 5,
	"weight growth rate": 1.395
}

var leaf5Values = {
	"id": 5,
	"level": 0,
	"max level": 10,
	"current price": 25000,
	"base price": 25000,
	"base value": 1500,
	"price growth rate": 1.8,
	"value growth rate": 1.65,
	"base weight": 5,
	"weight growth rate": 1.395
}	

var leafVolumeValues = {
	"id": "6",
	"level": 0,
	"max level": 10,
	"current price": 2000,
	"base price": 2000,
	"base bonus": 5,
	"price growth rate": 1.7,
	"bonus growth rate": 1.25,
	"base interval": 1.0,
	"interval decay rate": 0.9
}

var rootDamageValues = {
	"id": "7",
	"level": 0,
	"max level": 10,
	"current price": 300,
	"base price": 300,
	"base bonus": 1.0,
	"price growth rate": 1.5,
	"bonus growth rate": 1.15
}

var leafBlowerValues = {
	"id": "8",
	"level": 0,
	"max level": 1,
	"current price": 1000000
}

var leafList = [leaf1Values, leaf2Values, leaf3Values, leaf4Values, leaf5Values]
var upgradeList = [leaf1Values, leaf2Values, leaf3Values, leaf4Values, leaf5Values, leafVolumeValues, rootDamageValues, leafBlowerValues]

func get_leaf_by_id(id):
	for i in range(leafList.size()):
		if leafList[i]["id"] == id:
			return leafList[i]

func calculate_new_price(id):
	var dict = get_upgrade_by_id(id)
	dict["current price"] = int(ceil(dict["base price"] * pow(dict["price growth rate"], dict["level"])))

func calculate_new_value(id):
	var dict = get_leaf_by_id(id)
	return int(ceil(dict["base value"] * pow(dict["value growth rate"], dict["level"])))

func calculate_new_weight(id):
	var dict = get_leaf_by_id(id)
	var weight = 0
	
	if dict["level"] == 0:
		return weight
	else:
		weight = int(ceil(dict["base weight"] * pow(dict["weight growth rate"], dict["level"] - 1)))
		return weight

func level_up_leaf(id):
	var dict = get_leaf_by_id(id)
	if currencyManager.money >= dict["current price"] && dict["level"] < dict["max level"]:
		
		$"../Chacing".pitch_scale = randf_range(0.9, 1.1)
		$"../Chacing".play()
		
		currencyManager.remove_money(dict["current price"])
		dict["level"] += 1
		calculate_new_price(id)
		change_leaf_value(dict, calculate_new_value(id))
		change_leaf_weight(dict, calculate_new_weight(id))
	else:
		$"../Error".pitch_scale = randf_range(0.9, 1.1)
		$"../Error".play()
		pass

func change_leaf_value(dict, value):
	match dict["id"]:
		1:
			chute.leaf1Cost = value
		2:
			chute.leaf2Cost = value
		3:
			chute.leaf3Cost = value
		4:
			chute.leaf4Cost = value
		5:
			chute.leaf5Cost = value
		_:
			pass

func change_leaf_weight(dict, value):
	match dict["id"]:
		1:
			spawnManager.leaf1Weight = value
		2:
			spawnManager.leaf2Weight = value
		3:
			spawnManager.leaf3Weight = value
		4:
			spawnManager.leaf4Weight = value
		5:
			spawnManager.leaf5Weight = value
		_:
			pass

func get_level_and_price_by_id(id_str):
	var id = int(id_str)
	var upgrade
	for i in range(upgradeList.size()):
		if int(upgradeList[i]["id"]) == id:
			upgrade = upgradeList[i]
	var level = upgrade["level"]
	var maxLevel = upgrade["max level"]
	var price = upgrade["current price"]
	return [level, maxLevel, price]
	


func _ready() -> void:
	if SaveManager.has_save():
		apply_save_data(SaveManager.load_game())

func get_upgrade_by_id(id):
	for i in range(upgradeList.size()):
		if str(upgradeList[i]["id"]) == str(id):
			return upgradeList[i]

func apply_save_data(data: Dictionary) -> void:
	if data.is_empty():
		return
	currencyManager.money = int(data.get("money", currencyManager.money))
	var levels = data.get("levels", {})
	for id_str in levels.keys():
		var dict = get_upgrade_by_id(id_str)
		if dict == null:
			continue
		dict["level"] = int(levels[id_str])
		if typeof(dict["id"]) == TYPE_INT:
			calculate_new_price(dict["id"])
			change_leaf_value(dict, calculate_new_value(dict["id"]))
			change_leaf_weight(dict, calculate_new_weight(dict["id"]))

func level_up_upgrade(id):
	var dict = get_upgrade_by_id(id)
	if currencyManager.money >= dict["current price"] && dict["level"] < dict["max level"]:
		$"../Chacing".pitch_scale = randf_range(0.9, 1.1)
		$"../Chacing".play()
		
		currencyManager.remove_money(dict["current price"])
		dict["level"] += 1
		
		print(dict)
		
		match int(dict["id"]):
			6:
				increase_max_leaves(dict["id"])
				decrease_interval(dict["id"])
				calculate_new_price(id)
			7:
				pass
			8:
				get_tree().change_scene_to_file("res://Scenes/gg.tscn")
			_:
				pass
		
	else:
		$"../Error".pitch_scale = randf_range(0.9, 1.1)
		$"../Error".play()
		pass

func calculate_new_leaf_volume_bonus(id):
	var dict = get_upgrade_by_id(id)
	return dict["base bonus"] * pow(dict["bonus growth rate"], dict["level"])

func increase_max_leaves(id):
	var bonus = calculate_new_leaf_volume_bonus(id)
	spawnManager.maxLeaves = 100 + int(bonus) * 10

func decrease_interval(id):
	var dict = get_upgrade_by_id(id)
	var newInterval = dict["base interval"] * pow(dict["interval decay rate"], dict["level"])
	spawnManager.interval = max(0.1, newInterval)
	print(spawnManager.interval)
