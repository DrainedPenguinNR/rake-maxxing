extends Control

const SAVE_PATH = "user://savegame.json"

@onready var howto = $HowToMenu
@onready var settings = $SettingsMenu


func _on_how_to_pressed() -> void:
	$AudioStreamPlayer2D2.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D2.play()
	howto.active = true


func _on_start_pressed() -> void:
	$AudioStreamPlayer2D2.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D2.play()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_pressed() -> void:
	$AudioStreamPlayer2D2.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D2.play()
	get_tree().quit()
	


func _on_settings_pressed() -> void:
	settings.active=true
	$AudioStreamPlayer2D2.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D2.play()

# in SaveManager.gd
func wipe_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_PATH))

func _on_wipe_data_pressed() -> void:
	wipe_save()
	$AudioStreamPlayer2D2.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D2.play()

func _on_hover(button):
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D.play()
	get_node(button).modulate = Color(0.733, 0.733, 0.733, 1.0)
	
func _on_unhover(button):
	get_node(button).modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_volume_slider_value_changed(value: float) -> void:
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D.play()
	Volume.volume = value
