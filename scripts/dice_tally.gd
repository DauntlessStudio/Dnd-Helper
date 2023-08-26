class_name DiceTally
extends Resource

@export var diceMap: Dictionary = {
	"4": [],
	"6": [],
	"8": [],
	"10": [],
	"12": [],
	"20": [],
}

signal updateTally(total: int, recent: int)
signal resetTally

func addRoll(id: String, value: int):
	diceMap[id].append(value)
	updateTally.emit(getTally(), value)

func removeRoll(id: String):
	var recent = -diceMap[id].pop_back()
	updateTally.emit(getTally(), recent)

func clearTally():
	var oldTally = getTally()
	for dice in diceMap:
		diceMap[dice].clear()
	updateTally.emit(0, -oldTally)
	resetTally.emit()

func getTally() -> int:
	var count = 0
	for dice in diceMap:
		if !diceMap[dice].is_empty():
			count += diceMap[dice].reduce(func(accum, number): return accum + number)
	return count
