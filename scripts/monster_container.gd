class_name MonsterContainer
extends VBoxContainer

var sourceCharacter: Character
signal addMonster(character: Character)

func initialize(character: Character):
	sourceCharacter = character
	$Button/Name.text = sourceCharacter.name
	$Button/Size.text = str(sourceCharacter.sizeValues.keys()[sourceCharacter.size])
	$Button/Type.text = ", ".join(sourceCharacter.types)
	$Button/CR.text = character.challengeRating
	$Button/Alignment.text = character.alignment


func _on_button_pressed():
	addMonster.emit(sourceCharacter)
