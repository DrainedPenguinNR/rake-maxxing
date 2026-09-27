extends Node2D

signal root_broken

@onready var rake = get_tree().get_first_node_in_group("rake")
@onready var healthBar = $HealthBar

@export var maxHealth: float = 2000.0
var currentHealth: float
var isActive: bool = false
var lastDistance: float = 0.0

func _ready() -> void:
	currentHealth = maxHealth
	healthBar.max_value = maxHealth
	healthBar.value = currentHealth
	healthBar.visible = false

func _on_trap_area_area_entered(area: Area2D) -> void:
	print("caught")
	if area.is_in_group("rake") and not isActive:
		print("rake")
		trigger_trap()

func trigger_trap() -> void:
	isActive = true
	rake.is_paused = true
	lastDistance = rake.global_position.distance_to(rake.get_global_mouse_position())
	healthBar.visible = true

func _physics_process(delta: float) -> void:
	if not isActive:
		return

	var currentDistance = rake.global_position.distance_to(rake.get_global_mouse_position())

	if currentDistance <= rake.maxDistance:
		currentHealth -= abs(currentDistance - lastDistance)

	lastDistance = currentDistance
	healthBar.value = currentHealth

	if currentHealth <= 0:
		break_free()

func break_free() -> void:
	isActive = false
	rake.is_paused = false
	root_broken.emit()
	queue_free()
