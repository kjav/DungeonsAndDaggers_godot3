extends Node2D

var instance

func setInstance(newInstance):
	instance = newInstance
	get_node("ItemIcon/Icon").set_texture(instance.texture)

func getInstance():
	return instance
