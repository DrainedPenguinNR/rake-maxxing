extends Sprite2D



func _on_area_2d_mouse_entered() -> void:
	modulate = Color(1.0, 1.0, 1.0, 0.098)


func _on_area_2d_mouse_exited() -> void:
	modulate = Color(1.0, 1.0, 1.0, 0.588)
