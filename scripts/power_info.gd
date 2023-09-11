class_name PowerInfo
extends Popup


func _on_show_power_info(power: Power):
	$VBox/Name.text = power.name
	$VBox/ScrollContainer/VBox/Level.text = "[b]Level:[/b] %s" % str(power.level)
	$VBox/ScrollContainer/VBox/Period.text = "[b]Casting Period:[/b] %s" % power.castingPeriodValues.keys()[power.castingPeriod]
	$VBox/ScrollContainer/VBox/Duration.text = "[b]Duration:[/b] %s" % power.duration
	$VBox/ScrollContainer/VBox/Concentration.text = "[b]Concentration:[/b] %s" % str(power.concentration)
	$VBox/ScrollContainer/VBox/Description.text = power.description
	$VBox/ScrollContainer.scroll_vertical = 0
	popup()
	move_to_foreground()


func _on_close_requested():
	hide()
