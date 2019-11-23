extends Node2D

var instance

func setInstance(newInstance, count):
	instance = newInstance
	get_node("ItemTexture").set_texture(instance.texture)
	get_node("ItemBackground").set_texture(GameData.getBackgroundForRarity(instance.rarity))
	get_node("ItemName").text = instance.item_name
	get_node("ItemAmount").text = str(count)

func getInstance():
	return instance