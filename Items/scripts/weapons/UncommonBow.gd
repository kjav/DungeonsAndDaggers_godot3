extends "CommonBow.gd"

func _init():
	textureFilePath = "res://assets/uncommon-bow.png"
	texture = preload("res://assets/uncommon-bow.png")
	iconTextureFilePath = "res://assets/uncommon-bow-icon.png"
	iconTexture = preload("res://assets/uncommon-bow-icon.png")
	item_name = "Uncommon Bow"
	rarity = Enums.WEAPONRARITY.UNCOMMON
	ammo = 6