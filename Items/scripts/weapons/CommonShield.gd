extends "WeaponBase.gd"

var chanceToBlockOutOf = 7

func _init():
	iconFilePath = "res://assets/basic_shield.png"
	texture = preload("res://assets/basic_shield.png")
	item_name = "Common Shield"
	damage = 1

func onPlayerDamaged():
	if randi()%chanceToBlockOutOf+1 == 1:
		GameData.player.damageable = false
