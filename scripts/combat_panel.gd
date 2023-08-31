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
	sortInitiativePanel()


func sortInitiativePanel():
	var sorted_nodes := $CombatentStack/VBoxContainer/ScrollContainer/InitiativeStack.get_children()

	sorted_nodes.sort_custom(
	# For descending order use > 0
	func(a: Node, b: Node): return a.initiative > b.initiative
)

	for node in $CombatentStack/VBoxContainer/ScrollContainer/InitiativeStack.get_children():
		$CombatentStack/VBoxContainer/ScrollContainer/InitiativeStack.remove_child(node)

	for node in sorted_nodes:
		$CombatentStack/VBoxContainer/ScrollContainer/InitiativeStack.add_child(node)


func _on_exit_button_pressed():
	$AddMonsterPanel.visible = false


func _on_clear_button_pressed():
	for node in $CombatentStack/VBoxContainer/ScrollContainer/InitiativeStack.get_children():
		$CombatentStack/VBoxContainer/ScrollContainer/InitiativeStack.remove_child(node)
		node.queue_free()
