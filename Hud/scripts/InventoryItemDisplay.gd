extends Node2D

var instance

func setInstance(newInstance):
	instance = newInstance
	get_node("ItemTexture").set_texture(instance.texture)
	get_node("ItemBackground").set_texture(GameData.getBackgroundForRarity(instance.rarity))
	get_node("ItemName").text = instance.item_name

func getInstance():
	return instance