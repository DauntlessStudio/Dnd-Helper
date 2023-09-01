class_name AddMonsterPanel
extends PanelContainer

enum sizeValues {Unknown, Tiny, Small, Medium, Large, Huge, Gargantuan}
var displayMonsters: Array[MonsterContainer]
var searchString: String = ""
var sizeArr: Array[int] = []
var typeArr: Array[String] = []
var rateArr: Array[String] = []
var aligArr: Array[String] = []
var allSizeArr: Array[String] = []
var allTypeArr: Array[String] = []
var allRateArr: Array[String] = ["0", "1/8", "1/2", "1/4", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26"]
var allAligArr: Array[String] = []

signal addMonster(character: Character)

# Called when the node enters the scene tree for the first time.
func _ready():
	var dir_path = "res://resources/monsters"
	var files = DirAccess.get_files_at(dir_path)
	
	for file in files:
		if '.tres.remap' in file: # <---- NEW
			file = file.trim_suffix('.remap') # <---- NEW
		var monster = load(dir_path + "/" + file) as Character
		var container = load("res://scenes/monster_container.tscn") as PackedScene
		var instance = container.instantiate() as MonsterContainer
		instance.addMonster.connect(func (character: Character): addMonster.emit(character))
		displayMonsters.append(instance)
		instance.initialize(monster)
		$VBoxContainer/MonsterListHolder/ScrollContainer/MonsterListContainer.add_child(instance)
		add_search_categories(monster)
	
	for monsterSize in sizeValues:
		$VBoxContainer/SearchFlowContainer/SizeMenuButton.get_popup().add_check_item(monsterSize)
	$VBoxContainer/SearchFlowContainer/SizeMenuButton.get_popup().id_pressed.connect(_on_size_menu_pressed)
	
	for type in allTypeArr:
		$VBoxContainer/SearchFlowContainer/TypeMenuButton.get_popup().add_check_item(type)
	$VBoxContainer/SearchFlowContainer/TypeMenuButton.get_popup().id_pressed.connect(_on_type_menu_pressed)
	
	for rate in allRateArr:
		$VBoxContainer/SearchFlowContainer/CRMenuButton.get_popup().add_check_item(rate)
	$VBoxContainer/SearchFlowContainer/CRMenuButton.get_popup().id_pressed.connect(_on_cr_menu_pressed)
	
	for align in allAligArr:
		$VBoxContainer/SearchFlowContainer/AlignmentMenuButton.get_popup().add_check_item(align)
	$VBoxContainer/SearchFlowContainer/AlignmentMenuButton.get_popup().id_pressed.connect(_on_align_menu_pressed)
	
	visible = false

func add_search_categories(monster: Character):
	if !allSizeArr.has(str(monster.size)):
		allSizeArr.append(str(monster.size))
	
	for type in monster.types:
		if !allTypeArr.has(type):
			allTypeArr.append(type)
	
	if !allRateArr.has(monster.challengeRating):
		allRateArr.append(monster.challengeRating)
	
	if !allAligArr.has(monster.alignment):
		allAligArr.append(monster.alignment)

func update_display_list():
	for monsterDisplay in displayMonsters:
		var monster = monsterDisplay.sourceCharacter
		var matchSearch = searchString == "" || monster.name.to_lower().contains(searchString.to_lower())
		var matchSize = sizeArr.is_empty() || sizeArr.has(monster.size)
		var matchType = typeArr.is_empty() || array_overlap(typeArr, monster.types)
		var matchRating = rateArr.is_empty() || rateArr.has(monster.challengeRating)
		var matchAlignment = aligArr.is_empty() || aligArr.has(monster.alignment)
		monsterDisplay.visible = matchSearch && matchSize && matchType && matchRating && matchAlignment

func array_overlap(array1: Array, array2: Array) -> bool:
	for element in array1:
		if array2.has(element):
			return true
	return false

func _on_search_edit_text_changed(new_text):
	searchString = new_text
	update_display_list()

func _on_size_menu_pressed(id: int):
	var enabled = $VBoxContainer/SearchFlowContainer/SizeMenuButton.get_popup().is_item_checked(id)
	$VBoxContainer/SearchFlowContainer/SizeMenuButton.get_popup().set_item_checked(id, !enabled)
	
	await get_tree().create_timer(0.0).timeout
	$VBoxContainer/SearchFlowContainer/SizeMenuButton.show_popup()
	
	if enabled:
		sizeArr.erase(id)
	else:
		sizeArr.append(id)
	
	update_display_list()

func _on_type_menu_pressed(id: int):
	var enabled = $VBoxContainer/SearchFlowContainer/TypeMenuButton.get_popup().is_item_checked(id)
	$VBoxContainer/SearchFlowContainer/TypeMenuButton.get_popup().set_item_checked(id, !enabled)
	
	var value = $VBoxContainer/SearchFlowContainer/TypeMenuButton.get_popup().get_item_text(id)
	
	await get_tree().create_timer(0.0).timeout
	$VBoxContainer/SearchFlowContainer/TypeMenuButton.show_popup()
	
	if enabled:
		typeArr.erase(value)
	else:
		typeArr.append(value)
	
	update_display_list()

func _on_cr_menu_pressed(id: int):
	var enabled = $VBoxContainer/SearchFlowContainer/CRMenuButton.get_popup().is_item_checked(id)
	$VBoxContainer/SearchFlowContainer/CRMenuButton.get_popup().set_item_checked(id, !enabled)
	
	var value = $VBoxContainer/SearchFlowContainer/CRMenuButton.get_popup().get_item_text(id)
	
	await get_tree().create_timer(0.0).timeout
	$VBoxContainer/SearchFlowContainer/CRMenuButton.show_popup()
	
	if enabled:
		rateArr.erase(value)
	else:
		rateArr.append(value)
	
	update_display_list()

func _on_align_menu_pressed(id: int):
	var enabled = $VBoxContainer/SearchFlowContainer/AlignmentMenuButton.get_popup().is_item_checked(id)
	$VBoxContainer/SearchFlowContainer/AlignmentMenuButton.get_popup().set_item_checked(id, !enabled)
	
	var value = $VBoxContainer/SearchFlowContainer/AlignmentMenuButton.get_popup().get_item_text(id)
	
	await get_tree().create_timer(0.0).timeout
	$VBoxContainer/SearchFlowContainer/AlignmentMenuButton.show_popup()
	
	if enabled:
		aligArr.erase(value)
	else:
		aligArr.append(value)
	
	update_display_list()
