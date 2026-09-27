extends Control

var active = false
@onready var lvlManager = $"../LevelManager"

@onready var b1 = $YellowUpButton
@onready var b2 = $CrunchUpButton
@onready var b3 = $RainbowUpButton
@onready var b4 = $UpButton2
@onready var b5 = $UpButton3
@onready var b6 = $UpButton4
@onready var b7 = $UpButton5
@onready var b8 = $UpButton6

@onready var tooltip = $ToolTip
@onready var titleLabel = $ToolTip/Title
@onready var descriptionLabel = $ToolTip/Description

var topPos = Vector2(622, 159)

var botPos = Vector2(622, 539)

func _ready():
	for button in [b1, b2, b3, b4, b5, b6, b7, b8]:
		button.mouse_entered.connect(_on_button_mouse_entered.bind(button))
		button.mouse_exited.connect(_on_button_mouse_exited.bind(button))
		button.pressed.connect(_on_button_press.bind(button))
	
	b1.set_meta("unlock_text", "Unlock the Yellow leaf")
	b1.set_meta("tooltip_text", "Upgrade the Yellow leaf")
	b1.set_meta("tooltip_desc", "get more per leaf")
	b1.set_meta("location", "up")
	b1.set_meta("upgrade_type", "leaf")
	b1.set_meta("id", "1")
	
	b2.set_meta("unlock_text", "Unlock the Crunchy leaf")
	b2.set_meta("tooltip_text", "Upgrade the Crunchy leaf")
	b2.set_meta("tooltip_desc", "get more per leaf and increase spawn rate")
	b2.set_meta("location", "up")
	b2.set_meta("upgrade_type", "leaf")
	b2.set_meta("id", "2")
	
	b3.set_meta("unlock_text", "Unlock the Rainbow leaf")
	b3.set_meta("tooltip_text", "Upgrade the Rainbow leaf")
	b3.set_meta("tooltip_desc", "get more per leaf and increase spawn rate")
	b3.set_meta("location", "up")
	b3.set_meta("upgrade_type", "leaf")
	b3.set_meta("id", "3")
	
	b4.set_meta("unlock_text", "Unlock the Silver leaf")
	b4.set_meta("tooltip_text", "Upgrade the Siler leaf")
	b4.set_meta("tooltip_desc", "get more per leaf and increase spawn rate")
	b4.set_meta("location", "up")
	b4.set_meta("upgrade_type", "leaf")
	b4.set_meta("id", "4")
	
	b5.set_meta("unlock_text", "Unlock the Crystal leaf")
	b5.set_meta("tooltip_text", "Upgrade the Crystal leaf")
	b5.set_meta("tooltip_desc", "get more per leaf and increase spawn rate")
	b5.set_meta("location", "down")
	b5.set_meta("upgrade_type", "leaf")
	b5.set_meta("id", "5")
	
	b6.set_meta("tooltip_text", "Upgrade the Leaf Volume")
	b6.set_meta("tooltip_desc", "get more maximum leaves on the field and increase spawning interval")
	b6.set_meta("location", "down")
	b6.set_meta("upgrade_type", "gameplay")
	b6.set_meta("id", "6")
	
	b7.set_meta("tooltip_text", "Upgrade the Root Damage")
	b7.set_meta("tooltip_desc", "Get out of roots faster")
	b7.set_meta("location", "down")
	b7.set_meta("upgrade_type", "gameplay")
	b7.set_meta("id", "7")
	
	b8.set_meta("tooltip_text", "Buy the Leafblowinator")
	b8.set_meta("tooltip_desc", "the Final Goal")
	b8.set_meta("location", "down")
	b8.set_meta("upgrade_type", "gameplay")
	b8.set_meta("id", "8")
	
	set_text()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_S:
			active = !active
			visible = !visible
		
		if event.keycode == KEY_ESCAPE && active:
			active = false
			visible = false

func _on_button_mouse_entered(button):
	$"../Hover".pitch_scale = randf_range(0.9, 1.1)
	$"../Hover".play()
	
	button.modulate = Color(0.795, 0.795, 0.795, 1.0)
	
	var type = button.get_meta("upgrade_type")
	var title
	var desc
	var loc
	
	if type == "leaf":
		var lvl = lvlManager.get_level_and_price_by_id(button.get_meta("id"))
		if lvl[0] == 0:
			title = button.get_meta("unlock_text")
		else:
			title = button.get_meta("tooltip_text")
		
	elif type == "gameplay":
		title = button.get_meta("tooltip_text")
	
	desc = button.get_meta("tooltip_desc")
	loc = button.get_meta("location")
	
	show_tooltip(title, desc, loc)

func _on_button_mouse_exited(button):
	button.modulate = Color(1.0, 1.0, 1.0, 1.0)
	hide_tooltip()

func show_tooltip(title, description, location):
	tooltip.visible = true
	descriptionLabel.text = description
	titleLabel.text = title
	
	if location == "up":
		tooltip.position = botPos
	elif location == "down":
		tooltip.position = topPos
	else:
		tooltip.position = Vector2.ZERO

func hide_tooltip():
	tooltip.visible = false

func set_text():
	var buttonList = [b1, b2, b3, b4, b5, b6, b7, b8]
	for i in range(buttonList.size()):
		var button = buttonList[i]
		var data = lvlManager.get_level_and_price_by_id(button.get_meta("id"))
		var level = data[0]
		var maxLevel = data[1]
		var price = data[2]
		button.get_node("LevelText").text = "Level: " + str(level) + "/" + str(maxLevel)
		button.get_node("PriceText").text = "Price: " + str(price)

func _on_button_press(button):
	$"../Click".pitch_scale = randf_range(0.9, 1.1)
	$"../Click".play()
	var type = button.get_meta("upgrade_type")
	if type == "leaf":
		lvlManager.level_up_leaf(int(button.get_meta("id")))
	else:
		lvlManager.level_up_upgrade(int(button.get_meta("id")))
		print("passed " + str(button.get_meta("id")))
	set_text()
