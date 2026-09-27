extends NinePatchRect

var active = false

@onready var shop = $"../ShopUI"
@onready var rake = $"../rake"
@onready var spawn = $"../SpawnManager"
@onready var currencyManager = $"../CurrencyManager"
@onready var levelManager = $"../LevelManager"
@onready var SaveManager = $"../SaveManager"

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if not active && not shop.active:
			active = true
			visible = true
			rake.is_paused = true
			spawn.is_paused = true
		else:
			active = false
			visible = false
			rake.is_paused = false
			spawn.is_paused = false


func _on_resume_pressed() -> void:
	$"../Click".pitch_scale = randf_range(0.9, 1.1)
	$"../Click".play()
	active = false
	visible = false
	rake.is_paused = false
	spawn.is_paused = false

func _on_quit_to_menu_pressed() -> void:
	$"../Click".pitch_scale = randf_range(0.9, 1.1)
	$"../Click".play()
	var levels = {}
	for upgrade in levelManager.upgradeList:
		levels[str(upgrade["id"])] = upgrade["level"]

	var data = {
		"money": currencyManager.money,
		"levels": levels
	}
	SaveManager.save_game(data)
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
