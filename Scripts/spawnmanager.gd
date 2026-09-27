extends Node2D

var interval = 1
var maxLeaves = 100

var totalWeight
var leaf1Weight = 100
var leaf2Weight = 0
var leaf3Weight = 0
var leaf4Weight = 0
var leaf5Weight = 0

var _is_paused = false
@export var is_paused: bool:
	get:
		return _is_paused
	set(value):
		print("spawn setter called, value: ", value, " timer paused: ", timer.is_stopped())
		_is_paused = value
		if _is_paused:
			timer.stop()
		else:
			timer.start()

@onready var leaf1 = preload("res://Scenes/Leaves/yellowleaf.tscn")
@onready var leaf2 = preload("res://Scenes/Leaves/crunchyleaf.tscn")
@onready var leaf3 = preload("res://Scenes/Leaves/rainbowleaf.tscn")
@onready var leaf4 = preload("res://Scenes/Leaves/silverleaf.tscn")
@onready var leaf5 = preload("res://Scenes/Leaves/crystalleaf.tscn")
@onready var root = preload("res://Scenes/root.tscn")
@onready var timer = $Timer
@onready var leafList = $"../LeafList"

func _ready() -> void:
	timer.wait_time = interval
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	if _is_paused:
		return
	timer.wait_time = interval
	spawn_leaf()
	timer.start()

func spawn_leaf():
	var childCount = leafList.get_child_count()
	var weight = 0
	weight = leaf1Weight + leaf2Weight + leaf3Weight + leaf4Weight + leaf5Weight
	var roll = randi_range(0, weight)
	
	if roll <= leaf1Weight:
		spawnLeaf1(childCount)
	
	elif roll <= leaf1Weight + leaf2Weight:
		spawnLeaf2(childCount)
	
	elif roll <= leaf1Weight + leaf2Weight + leaf3Weight:
		spawnLeaf3(childCount)
	
	elif roll <= leaf1Weight + leaf2Weight + leaf3Weight + leaf4Weight:
		spawnLeaf4(childCount)
	
	elif roll <= leaf1Weight + leaf2Weight + leaf3Weight + leaf4Weight + leaf5Weight:
		spawnLeaf5(childCount)
	
	else:
		pass
	
	var chance = randi_range(0, 100)
	if chance < 2:
		spawnRoot()

func spawnLeaf1(childCount):
	if childCount < maxLeaves:
		var leaf = leaf1.instantiate()
		var screen_size = get_viewport_rect().size
		var random_x = randf_range(0, screen_size.x)
		var random_y = randf_range(0, screen_size.y)
		var random_pos = Vector2(random_x, random_y)
		var random_rot = randf_range(-3.14, 3.14)
		leaf.rotation = random_rot
		leaf.position = random_pos
		leaf.add_to_group("leaf1")
		leafList.add_child(leaf)

func spawnLeaf2(childCount):
	if childCount < maxLeaves:
		var leaf = leaf2.instantiate()
		var screen_size = get_viewport_rect().size
		var random_x = randf_range(0, screen_size.x)
		var random_y = randf_range(0, screen_size.y)
		var random_pos = Vector2(random_x, random_y)
		var random_rot = randf_range(-3.14, 3.14)
		leaf.rotation = random_rot
		leaf.position = random_pos
		leaf.add_to_group("leaf2")
		leafList.add_child(leaf)

func spawnLeaf3(childCount):
	if childCount < maxLeaves:
		var leaf = leaf3.instantiate()
		var screen_size = get_viewport_rect().size
		var random_x = randf_range(0, screen_size.x)
		var random_y = randf_range(0, screen_size.y)
		var random_pos = Vector2(random_x, random_y)
		var random_rot = randf_range(-3.14, 3.14)
		leaf.rotation = random_rot
		leaf.position = random_pos
		leaf.add_to_group("leaf3")
		leafList.add_child(leaf)

func spawnLeaf4(childCount):
	if childCount < maxLeaves:
		var leaf = leaf4.instantiate()
		var screen_size = get_viewport_rect().size
		var random_x = randf_range(0, screen_size.x)
		var random_y = randf_range(0, screen_size.y)
		var random_pos = Vector2(random_x, random_y)
		var random_rot = randf_range(-3.14, 3.14)
		leaf.rotation = random_rot
		leaf.position = random_pos
		leaf.add_to_group("leaf4")
		leafList.add_child(leaf)

func spawnLeaf5(childCount):
	if childCount < maxLeaves:
		var leaf = leaf5.instantiate()
		var screen_size = get_viewport_rect().size
		var random_x = randf_range(0, screen_size.x)
		var random_y = randf_range(0, screen_size.y)
		var random_pos = Vector2(random_x, random_y)
		var random_rot = randf_range(-3.14, 3.14)
		leaf.rotation = random_rot
		leaf.position = random_pos
		leaf.add_to_group("leaf5")
		leafList.add_child(leaf)

func spawnRoot():
	var rootS = root.instantiate()
	var screen_size = get_viewport_rect().size
	var random_x = randf_range(0, screen_size.x)
	var random_y = randf_range(0, screen_size.y)
	var random_pos = Vector2(random_x, random_y)
	var random_rot = randf_range(-3.14, 3.14)
	rootS.rotation = random_rot
	rootS.position = random_pos
	rootS.add_to_group("root")
	leafList.add_child(rootS)
