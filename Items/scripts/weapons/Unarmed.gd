extends "WeaponBase.gd"

func _init():
	iconFilePath = "res://assets/transparent_pixel.png"
	texture = preload("res://assets/transparent_pixel.png")
	item_name = "Your Fist"
	equiptable = false
	damage = 0.5
