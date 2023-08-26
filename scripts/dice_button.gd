extends Button

@export var diceValue: int = 4
@export var diceTally: DiceTally = load("res://resources/dice_tally.tres") as DiceTally
var rollCount: int = 0
var max_int = 9223372036854775807

func _ready():
	diceTally.resetTally.connect(func (): 
		rollCount = 0
		$Label.text = ""
	)

func updateRollCount(value: int):
	rollCount = clamp(rollCount + value, 0, max_int)
	if rollCount > 0:
		$Label.text = "x%02d" % rollCount
	else:
		$Label.text = ""

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				updateRollCount(1)
				diceTally.addRoll(str(diceValue), randi_range(1, diceValue))
			MOUSE_BUTTON_RIGHT:
				updateRollCount(-1)
				diceTally.removeRoll(str(diceValue))
