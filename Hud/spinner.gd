extends TextureRect

var time = 0

func _process(delta):
	time += delta
	if time > 0.08:
		set_rotation(get_rotation() + PI / 6.0)
		time = 0
