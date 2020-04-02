extends TextureRect

export(bool) var grayscale setget set_grayscale, get_grayscale

func set_grayscale(val):
	material.set_shader_param("grayscale", val)

func get_grayscale():
	return material.get_shader_param("grayscale")
