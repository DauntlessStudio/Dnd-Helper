extends Button

@export var diceTally: DiceTally = load("res://resources/dice_tally.tres") as DiceTally
var currentTotal = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	diceTally.updateTally.connect(_onDiceTallyUpdated)
	text = ""

func _onDiceTallyUpdated(total: int, recent: int):
	currentTotal = total
	text = "%02d" % total
	
	var prefix = "+" if recent > 0 else ""
	$Label.text = prefix + "%d" % recent
	$Timer.start(1)

func _hideRecentText():
	$Label.text = ""
	if currentTotal <= 0:
		text = ""

func _on_pressed():
	diceTally.clearTally()
