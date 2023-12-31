class_name Character
extends Resource

enum sizeValues {Unknown, Tiny, Small, Medium, Large, Huge, Gargantuan}
enum damageTypeValues {Unknown, Acid, Cold, Energy, Fire, Force, Ion, Kinetic, Lightning, Necrotic, Poison, Psychic, Sonic}
@export var name: String
@export var flavorText: String
@export var sectionText: String
@export var size: sizeValues
@export var types: Array[String]
@export var alignment: String
@export var armorType: String
@export var armorClass: int
@export var hitPoints: int
@export var speed: int
@export var strength: int
@export var dexterity: int
@export var constitution: int
@export var intelligence: int
@export var wisdom: int
@export var charisma: int
@export var savingThrows: Array[String]
@export var skills: Array[String]
@export var damageImmunities: Array[damageTypeValues]
@export var damageResistances: Array[damageTypeValues]
@export var damageVulnerabilities: Array[damageTypeValues]
@export var conditionImmunities: Array[String]
@export var senses: Array[String]
@export var languages: Array[String]
@export var challengeRating: String
@export var experiencePoints: int
@export var behaviors: Array[Behavior]

func getModifierFromScore(score: int) -> int:
	score = score - 10
	if score != 0:
		score = floor(score / 2.0)
	return score

func formattedScore(score: int) -> String:
	var mod = getModifierFromScore(score)
	var plus = "+" if mod >= 0 else ""
	return "%d (%s%d)" % [score, plus, mod]

func damage_array_join(arr : Array, glue : String = '') -> String:
	var string : String = '' if arr.size() > 0 else 'None'
	for index in range(0, arr.size()):
		string += damageTypeValues.keys()[arr[index]]
		if index < arr.size() - 1:
			string += glue
	return string
