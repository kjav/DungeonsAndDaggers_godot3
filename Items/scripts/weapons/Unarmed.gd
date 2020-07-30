extends "WeaponBase.gd"

func _init():
	._init()
	textureFilePath = "res://assets/transparent_pixel.png"
	texture = preload("res://assets/transparent_pixel.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	item_name = "Unarmed"
	item_description = "Pick up a weapon to fill this slot. Unarmed will only deal a base of 0.5."
	equiptable = false
	damage = 0.5
