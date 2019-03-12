extends Node2D

var instance

func setInstance(newInstance):
	instance = newInstance
	get_node("ItemIcon/Icon").set_texture(instance.texture)
	get_node("ItemDescription/Description").set_text(instance.description)
	get_node("ItemDescription/Name").set_text(instance.item_name)

func getInstance():
	return instance
