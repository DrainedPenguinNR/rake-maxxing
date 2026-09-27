extends NinePatchRect

var active = false

func _process(delta: float) -> void:
	if active:
		visible = true
	else:
		visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE && active:
			$"../AudioStreamPlayer2D2".pitch_scale = randf_range(0.9, 1.1)
			$"../AudioStreamPlayer2D2".play()
			active = false
			

func _on_back_pressed() -> void:
	$"../AudioStreamPlayer2D2".pitch_scale = randf_range(0.9, 1.1)
	$"../AudioStreamPlayer2D2".play()
	active = false
