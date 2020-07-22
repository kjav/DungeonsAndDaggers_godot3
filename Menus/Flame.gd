extends Sprite

func _ready():
	var time_offset = randf() * 1000.0
	print("Time offset: ", time_offset)
	material.set_shader_param("time_offset", time_offset)
