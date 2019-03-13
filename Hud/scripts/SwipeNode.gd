extends Node2D

signal swipe
var swipe_start = null
var minimum_drag = 30

func _input(event):
	if event.is_action_pressed("click"):
		swipe_start = event.global_position
	if event.is_action_released("click"):
		_calculate_swipe(event.global_position)

func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start

	print("Distance: ", swipe.length())

	if swipe.length() > minimum_drag:
		swipe = swipe.normalized()
		if abs(swipe.x) > 0.2:
			if swipe.x > 0:
				emit_signal("swipe", Enums.DIRECTION.RIGHT)
			else:
				emit_signal("swipe", Enums.DIRECTION.LEFT)
		if abs(swipe.y) > 0.2:
			if swipe.y > 0:
				emit_signal("swipe", Enums.DIRECTION.DOWN)
			else:
				emit_signal("swipe", Enums.DIRECTION.UP)