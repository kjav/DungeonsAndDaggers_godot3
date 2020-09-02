extends "CommonHammer.gd"

func _init():
	._init()
	textureFilePath = "res://assets/Hammers/ActionLoot_103.png"
	texture = preload("res://assets/Hammers/ActionLoot_103.png")
	offhandTexture = preload("res://assets/Hammers/ActionLoot_103.png")
	offhandTextureFilePath = "res://assets/Hammers/ActionLoot_103.png"
	iconTexture = preload("res://assets/Hammers/ActionLoot_103.png")
	iconTextureFilePath = "res://assets/Hammers/ActionLoot_103.png"
	item_name = "Uncommon Hammer"
	item_description = "Hammers alternate between additionally attacking behind or to the sides of the target. Uncommon has a base damage of 2."
	damage = 2
	rarity = Enums.WEAPONRARITY.UNCOMMON
