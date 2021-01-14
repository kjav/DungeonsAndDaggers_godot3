tool
extends Sprite

export(bool) var direction setget setDirection, getDirection

var time = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if is_visible():
			self.offset.y = sin(time * 2.5) * 5

func getDirection():
	return direction

func setDirection(_d):
	direction = _d
	if direction:
		self.rotation_degrees = 90
	else:
		self.rotation_degrees = 0
