extends Label

@onready var timer = $Timer
var value = 0

func _ready() -> void:
	timer.start()
	timer.timeout.connect(_on_timer_end)

func _process(delta: float) -> void:
	position.y -= delta * 20
	

func _on_timer_end():
	queue_free()

func update_text():
	text = "$" + str(int(value))
