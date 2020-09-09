extends "CommonHammer.gd"

func _init():
	._init()
	textureFilePath = "res://assets/Staves/uncommon_staff.png"
	texture = preload("res://assets/Staves/uncommon_staff.png")
	offhandTexture = preload("res://assets/Staves/uncommon_staff.png")
	offhandTextureFilePath = "res://assets/Staves/uncommon_staff.png"
	iconTexture = preload("res://assets/Staves/uncommon_staff_icon.png")
	iconTextureFilePath = "res://assets/Staves/uncommon_staff_icon.png"
	item_name = "Uncommon Hammer"
	item_description = "Hammers alternate between additionally attacking behind or to the sides of the target. Uncommon has a base damage of 2."
	damage = 2
	rarity = Enums.WEAPONRARITY.UNCOMMON
