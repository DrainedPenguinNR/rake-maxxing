extends Node2D

func _on_hover_darken(button):
	get_node(button).modulate = Color(0.799, 0.799, 0.799, 1.0)
	$"Hover".pitch_scale = randf_range(0.9, 1.1)
	$"Hover".play()

func _on_unhover_lighen(button):
	get_node(button).modulate = Color(1.0, 1.0, 1.0, 1.0)
