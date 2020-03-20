extends "WeaponBase.gd"

func _init():
	textureFilePath = "res://assets/transparent_pixel.png"
	texture = preload("res://assets/transparent_pixel.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	item_name = "Your Fist"
	equiptable = false
	damage = 0.5
