extends "WeaponBase.gd"

var chanceToBlockOutOf = 6

func _init():
	iconFilePath = "res://assets/basic_shield.webp"
	texture = preload("res://assets/basic_shield.webp")
	item_name = "Common Shield"
	damage = 1

func onPlayerDamaged():
	if randi() % int(chanceToBlockOutOf + 1) == 1:
		GameData.player.damageable = false
