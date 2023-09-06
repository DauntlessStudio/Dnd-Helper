class_name MonsterInfoWindow
extends Popup

var combatantPanel: CombatentStackPanel

var NameLabel: Label
var DescriptionLabel: RichTextLabel
var ArmorClassLabel: RichTextLabel
var SpeedLabel: RichTextLabel
var STRLabel: Label
var DEXLabel: Label
var CONLabel: Label
var INLabel: Label
var WISLabel: Label
var CHALabel: Label
var SkillsLabel: RichTextLabel
var VulnerabilitiesLabel: RichTextLabel
var ResistancesLabel: RichTextLabel
var DamageImmunities: RichTextLabel
var ImmunitiesLabel: RichTextLabel
var SensesLabel: RichTextLabel
var LanguagesLabel: RichTextLabel
var ChallengeLabel: RichTextLabel
var TraitContentsLabel: RichTextLabel
var ActionContentsLabel: RichTextLabel
var ReactionContentsLabel: RichTextLabel
var LegendaryContentsLabel: RichTextLabel

func _ready():
	NameLabel = $ScrollContainer/VBoxContainer/NameLabel
	DescriptionLabel = $ScrollContainer/VBoxContainer/DescriptionLabel
	ArmorClassLabel = $ScrollContainer/VBoxContainer/ArmorClassLabel
	SpeedLabel = $ScrollContainer/VBoxContainer/SpeedLabel
	STRLabel = $ScrollContainer/VBoxContainer/HBoxContainer/STRLabel
	DEXLabel = $ScrollContainer/VBoxContainer/HBoxContainer/DEXLabel
	CONLabel = $ScrollContainer/VBoxContainer/HBoxContainer/CONLabel
	INLabel = $ScrollContainer/VBoxContainer/HBoxContainer/INTLabel
	WISLabel = $ScrollContainer/VBoxContainer/HBoxContainer/WISLabel
	CHALabel = $ScrollContainer/VBoxContainer/HBoxContainer/CHALabel
	SkillsLabel = $ScrollContainer/VBoxContainer/SkillsLabel
	VulnerabilitiesLabel = $ScrollContainer/VBoxContainer/VulnerabilitiesLabel
	ResistancesLabel = $ScrollContainer/VBoxContainer/ResistancesLabel
	DamageImmunities = $ScrollContainer/VBoxContainer/DMGImmuneLabel
	ImmunitiesLabel = $ScrollContainer/VBoxContainer/ImmunitiesLabel
	SensesLabel = $ScrollContainer/VBoxContainer/SensesLabel
	LanguagesLabel = $ScrollContainer/VBoxContainer/LanguagesLabel
	ChallengeLabel = $ScrollContainer/VBoxContainer/ChallengeLabel
	TraitContentsLabel = $ScrollContainer/VBoxContainer/TraitContainer/Contents
	ActionContentsLabel = $ScrollContainer/VBoxContainer/ActionContainer/Contents
	ReactionContentsLabel = $ScrollContainer/VBoxContainer/ReactionContainer/Contents
	LegendaryContentsLabel = $ScrollContainer/VBoxContainer/LegendaryContainer/Contents

func _on_show_combatant_info(combatant: CombatentStackPanel):
	combatantPanel = combatant
	var character: Character = combatant.sourceCharacter
	NameLabel.text = character.name
	DescriptionLabel.text = "[i]%s %s, %s[/i]" % [character.sizeValues.keys()[character.size], array_join(character.types, ","), character.alignment]
	ArmorClassLabel.text = "[b]Armor Class[/b] %d" % character.armorClass
	SpeedLabel.text = "[b]Speed[/b] %d ft." % character.speed
	STRLabel.text = "STR\n%s" % [character.formattedScore(character.strength)]
	DEXLabel.text = "DEX\n%s" % [character.formattedScore(character.dexterity)]
	CONLabel.text = "CON\n%s" % [character.formattedScore(character.constitution)]
	INLabel.text = "INT\n%s" % [character.formattedScore(character.intelligence)]
	WISLabel.text = "WIS\n%s" % [character.formattedScore(character.wisdom)]
	CHALabel.text = "CHA\n%s" % [character.formattedScore(character.charisma)]
	SkillsLabel.text = "[b]Skills[/b] %s" % array_join(character.skills, ",")
	VulnerabilitiesLabel.text = "[b]Damage Vulnerabilities[/b] %s" % character.damage_array_join(character.damageVulnerabilities, ",")
	ResistancesLabel.text = "[b]Damage Resistances[/b] %s" % character.damage_array_join(character.damageResistances, ",")
	DamageImmunities.text = "[b]Damage Resistances[/b] %s" % character.damage_array_join(character.damageImmunities, ",")
	ImmunitiesLabel.text = "[b]Condition Immunities[/b] %s" % array_join(character.conditionImmunities, ",")
	SensesLabel.text = "[b]Senses[/b] %s" % array_join(character.senses, ",")
	LanguagesLabel.text = "[b]Languages[/b] %s" % array_join(character.languages, ",")
	ChallengeLabel.text = "[b]Challenge[/b] %s (%d XP)" % [character.challengeRating, character.experiencePoints]
	var TraitCount = 0
	TraitContentsLabel.text = ""
	var ActionCount = 0
	ActionContentsLabel.text = ""
	var ReactionCount = 0
	ReactionContentsLabel.text = ""
	var LegendaryCount = 0
	LegendaryContentsLabel.text = ""
	
	for behavior in character.behaviors:
		match behavior.monsterBehaviorType:
			behavior.behaviorValues.Trait:
				TraitContentsLabel.text += "[b]%s[/b]" % behavior.name
				TraitContentsLabel.text += "\n%s\n" % behavior.descriptionWithLinks
				TraitCount += 1
			behavior.behaviorValues.Action:
				ActionContentsLabel.text += "[b]%s[/b]" % behavior.name
				ActionContentsLabel.text += "\n%s\n" % behavior.descriptionWithLinks
				ActionCount += 1
			behavior.behaviorValues.Reaction:
				ReactionContentsLabel.text += "[b]%s[/b]" % behavior.name
				ReactionContentsLabel.text += "\n%s\n" % behavior.descriptionWithLinks
				ReactionCount += 1
			behavior.behaviorValues.Legendary:
				LegendaryContentsLabel.text += "[b]%s[/b]" % behavior.name
				LegendaryContentsLabel.text += "\n%s\n" % behavior.descriptionWithLinks
				LegendaryCount += 1
	
	$ScrollContainer/VBoxContainer/TraitContainer.visible = TraitCount > 0
	$ScrollContainer/VBoxContainer/ActionContainer.visible = ActionCount > 0
	$ScrollContainer/VBoxContainer/ReactionContainer.visible = ReactionCount > 0
	$ScrollContainer/VBoxContainer/LegendaryContainer.visible = LegendaryCount > 0
	popup()


func _on_close_requested():
	hide()

func array_join(arr : Array, glue : String = '') -> String:
	var string : String = '' if arr.size() > 0 else 'None'
	for index in range(0, arr.size()):
		string += str(arr[index])
		if index < arr.size() - 1:
			string += glue
	return string
