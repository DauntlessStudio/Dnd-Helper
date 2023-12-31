class_name CombatentStackPanel
extends Panel

@export var sourceCharacter: Character
signal combatantInfo(combatant: CombatentStackPanel)
var currentHP: int
var maximumHP: int
var initiative: int

func set_character(character: Character):
	sourceCharacter = character
	maximumHP = sourceCharacter.hitPoints
	currentHP = maximumHP
	initiative = randi_range(1, 20)
	
	$VBoxContainer/NameLineEdit.placeholder_text = sourceCharacter.name
	$VBoxContainer/HBoxContainer/InitiativeLabel.text = "%02d" % initiative
	$VBoxContainer/HBoxContainer/VBoxContainer/HPLabel.text = " %d/%d" % [currentHP, maximumHP]
	$VBoxContainer/HBoxContainer/VBoxContainer/HSlider.max_value = maximumHP
	$VBoxContainer/HBoxContainer/VBoxContainer/HSlider.value = currentHP
	$VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpeedLabel.text = " %s" % sourceCharacter.speed
	$VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/ArmorLabel.text = " %s" % sourceCharacter.armorClass

func set_player(playerName: String, init: int, armor: String, movement: String, hp: int):
	initiative = init
	maximumHP = hp
	currentHP = maximumHP
	movement = movement if !movement.is_empty() else "30"
	armor = armor if !armor.is_empty() else "0"
	$VBoxContainer/HBoxContainer/InitiativeLabel.text = "%02d" % initiative
	$VBoxContainer/HBoxContainer/VBoxContainer/HPLabel.text = " %d/%d" % [currentHP, maximumHP]
	$VBoxContainer/HBoxContainer/VBoxContainer/HSlider.max_value = maximumHP
	$VBoxContainer/HBoxContainer/VBoxContainer/HSlider.value = currentHP
	$VBoxContainer/NameLineEdit.text = playerName if !playerName.is_empty() else "Player"
	$VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpeedLabel.text = " %s" % movement
	$VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/ArmorLabel.text = " %s" % armor

func _on_hp_slider_value_changed(value):
	hp_value_changed(value)


func _on_clear_button_pressed():
	queue_free()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		combatantInfo.emit(self)


func _on_hp_label_pressed():
	$Window/Panel/SpinBox.value = 0
	$Window.popup()
	$Window/Panel/SpinBox.get_line_edit().grab_focus()


func _on_add_button_pressed():
	var value = clampi(currentHP + int($Window/Panel/SpinBox.value), 0, maximumHP)
	hp_value_changed(value)
	_on_window_close_requested()


func _on_subtract_button_pressed():
	var value = clampi(currentHP - int($Window/Panel/SpinBox.value), 0, maximumHP)
	hp_value_changed(value)
	_on_window_close_requested()
	
func hp_value_changed(value):
		currentHP = value
		$VBoxContainer/HBoxContainer/VBoxContainer/HPLabel.text = " %d/%d" % [currentHP, maximumHP]
		$VBoxContainer/HBoxContainer/VBoxContainer/HSlider.value = value


func _on_window_close_requested():
	$Window.hide()

