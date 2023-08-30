extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AddMonsterPanel.addMonster.connect(addMonster)



func _on_new_monster_button_pressed():
	$AddMonsterPanel.visible = true


func addMonster(character: Character):
	print(character.name)
	var panel = load("res://scenes/combatent_stack_panel.tscn") as PackedScene
	var instance = panel.instantiate() as CombatentStackPanel
	instance.set_character(character)
	$CombatentStack/VBoxContainer/ScrollContainer/InitiativeStack.add_child(instance)


func _on_exit_button_pressed():
	$AddMonsterPanel.visible = false
