extends CharacterBody2D

@export var maxDistance = 225.0
@export var currentDistance = 225.0
@export var rakeSpeedModifier = 30
@export var minRakeSpeed = 6
@export var is_paused = false

var rakeSpeed = 6.0

func _input(event: InputEvent) -> void:
	if is_paused:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			currentDistance = lerp(currentDistance, 0.0, 5.0)
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			currentDistance = maxDistance

func _physics_process(delta: float) -> void:
	if is_paused:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var mousePos = get_global_mouse_position()
	var dir = global_position.direction_to(mousePos)
	var dist = global_position.distance_to(mousePos)

	# Rotate
	rotation = dir.angle()

	# Speed scales with distance (no delta here)
	rakeSpeed = minRakeSpeed + dist * rakeSpeedModifier

	if dist > currentDistance:
		velocity = dir * rakeSpeed
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.2)

	move_and_slide()
