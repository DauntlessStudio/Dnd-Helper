extends Node


# Called when the node enters the scene tree for the first time.
func generate():
	var file = FileAccess.open("res://assets/monsters.json", FileAccess.READ)
	var monsters = JSON.parse_string(file.get_as_text())
	for monster in monsters:
		var resCharacter = Character.new()
		resCharacter.name = monster.name
		resCharacter.flavorText = monster.flavorText
		resCharacter.sectionText = monster.sectionText
		resCharacter.size = monster.sizeEnum
		resCharacter.types.append_array(monster.types)
		resCharacter.alignment = monster.alignment
		resCharacter.armorType = monster.armorType if monster.armorType else "None"
		resCharacter.armorClass = monster.armorClass
		resCharacter.hitPoints = monster.hitPoints
		resCharacter.speed = monster.speed
		resCharacter.strength = monster.strength
		resCharacter.dexterity = monster.dexterity
		resCharacter.constitution = monster.constitution
		resCharacter.intelligence = monster.intelligence
		resCharacter.wisdom = monster.wisdom
		resCharacter.charisma = monster.charisma
		if monster.savingThrows:
			resCharacter.savingThrows.append_array(monster.savingThrows)
		if monster.skills:
			resCharacter.skills.append_array(monster.skills)
		if !monster.damageImmunitiesParsed.is_empty():
			resCharacter.damageImmunities.append_array(monster.damageImmunitiesParsed.map(func(val): return roundi(val)))
		if !monster.damageResistancesParsed.is_empty():
			resCharacter.damageResistances.append_array(monster.damageResistancesParsed.map(func(val): return roundi(val)))
		if !monster.damageVulnerabilitiesParsed.is_empty():
			resCharacter.damageVulnerabilities.append_array(monster.damageVulnerabilitiesParsed.map(func(val): return roundi(val)))
		resCharacter.conditionImmunities.append_array(monster.conditionImmunities)
		if monster.senses:
			resCharacter.senses.append_array(monster.senses)
		resCharacter.languages.append_array(monster.languages)
		resCharacter.challengeRating = monster.challengeRating
		resCharacter.experiencePoints = monster.experiencePoints
		resCharacter.behaviors.append_array(monster.behaviors.map(create_behavior))
		var filename = "res://resources/monsters/%s.tres" % monster.name.replace(" ", "_").replace("/", "-").to_lower()
		print(filename)
		ResourceSaver.save(resCharacter, filename)

func create_behavior(behavior: Dictionary) -> Behavior:
	var createdBehavior = Behavior.new()
	createdBehavior.name = behavior.name
	createdBehavior.monsterBehaviorType = behavior.monsterBehaviorType
	createdBehavior.description = behavior.description
	
	var formatted_string = behavior.descriptionWithLinks
	var regex = RegEx.new()
	regex.compile("(\\[.*?\\])(\\(.*?\\))")
	var results = regex.search_all(behavior.descriptionWithLinks)
	for result in results:
		var display_string = result.strings[1].replace("[", "").replace("]", "")
		var url_string = display_string.replace(" ", "_").replace("/", "-")
		url_string = "[url=%s]%s[/url]" % [url_string, display_string]
		formatted_string = formatted_string.replace(result.get_string(), url_string)
	createdBehavior.descriptionWithLinks = formatted_string
	createdBehavior.attackType = behavior.attackType
	createdBehavior.restrictions = behavior.restrictions if behavior.restrictions else ""
	createdBehavior.attackRange = behavior.range if behavior.range else ""
	createdBehavior.attackBonus = behavior.attackBonus
	createdBehavior.numberOfTargets = behavior.numberOfTargets if behavior.numberOfTargets else ""
	createdBehavior.damage = behavior.damage if behavior.damage else 0
	createdBehavior.damageRoll = behavior.damageRoll if behavior.damageRoll else ""
	createdBehavior.damageType = behavior.damageTypeEnum
	return createdBehavior
