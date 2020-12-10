extends "CommonStaff.gd"

func _init():
	._init()
	textureFilePath = "res://assets/Staves/rare_staff.png"
	texture = preload("res://assets/Staves/rare_staff.png")
	offhandTexture = preload("res://assets/Staves/rare_staff.png")
	offhandTextureFilePath = "res://assets/Staves/rare_staff.png"
	iconTexture = preload("res://assets/Staves/rare_staff_icon.png")
	iconTextureFilePath = "res://assets/Staves/rare_staff_icon.png"
	item_name = "Rare Staff"
	item_description = "Staves alternate between additionally attacking behind or to the sides of the target. Rare has a base damage of 2.5."
	damage = 2.5
	rarity = Enums.WEAPONRARITY.RARE
