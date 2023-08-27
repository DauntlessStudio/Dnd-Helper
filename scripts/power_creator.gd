extends Node


# Called when the node enters the scene tree for the first time.
func generate():
	var file = FileAccess.open("res://assets/powers.json", FileAccess.READ)
	var powers = JSON.parse_string(file.get_as_text())
	for power in powers:
		var resPower = Power.new()
		resPower.name = power.name
		resPower.powerType = power.powerType
		resPower.prerequisite = power.prerequisite if power.prerequisite else ""
		resPower.level = power.level
		resPower.castingPeriod = power.castingPeriod
		resPower.powerRange = power.range
		resPower.duration = power.duration
		resPower.concentration = power.concentration
		resPower.forceAlignment = power.forceAlignment
		resPower.description = power.description
		resPower.higherLevelDescription = power.higherLevelDescription if power.higherLevelDescription else ""
		var filename = "res://resources/powers/%s.tres" % resPower.name.replace(" ", "_").replace("/", "-").to_lower()
		print(filename)
		ResourceSaver.save(resPower, filename)
