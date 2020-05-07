extends Node2D
var current_time = 0

func setDirection(direction):
	if direction == Enums.DIRECTION.RIGHT:
		set_rotation(PI / 2)
	elif direction == Enums.DIRECTION.DOWN:
		set_rotation(PI)
	elif direction == Enums.DIRECTION.LEFT:
		set_rotation(3 * PI / 2)
	elif direction == Enums.DIRECTION.UP:
		set_rotation(0)

func _process(delta):
	if current_time < 10:
		var a = (abs(float(sin(current_time))) / 6 + 0.75)*0.25
		
		set_scale(Vector2(a,a))
		current_time += delta