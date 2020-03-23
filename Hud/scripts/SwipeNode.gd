extends Node2D

signal swipe
signal click
var swipe_start = null
var minimum_drag = 30

func _input(event):
	if event.is_action_pressed("click"):
		swipe_start = event.global_position
	if event.is_action_released("click"):
		_calculate_swipe(event)

func _calculate_swipe(event):
	var swipe_end = event.global_position
	if swipe_start == null:
		return
	var swipe = swipe_end - swipe_start
	
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	
	swipe.x * float(width) / height
	swipe.y * float(height) / width

	if swipe.length() > minimum_drag:
		swipe = swipe.normalized()
		
		if abs(swipe.x) > abs(swipe.y):
			if swipe.x > 0:
				emit_signal("swipe", Enums.DIRECTION.RIGHT)
			else:
				emit_signal("swipe", Enums.DIRECTION.LEFT)
		else:
			if swipe.y > 0:
				emit_signal("swipe", Enums.DIRECTION.DOWN)
			else:
				emit_signal("swipe", Enums.DIRECTION.UP)
		GameData.click_state = false
	else:
		emit_signal("click", event)
		GameData.click_state = event
