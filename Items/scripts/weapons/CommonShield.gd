extends "WeaponBase.gd"

var chanceToBlockOutOf = 6

func _init():
	textureFilePath = "res://assets/basic_shield.webp"
	texture = preload("res://assets/basic_shield.webp")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/basic_shield.webp"
	iconTexture = preload("res://assets/basic_shield.webp")
	item_name = "Common Shield"
	damage = 1
	isMelee = true
	isOffhand = true
	rotationInHand = deg2rad(100)
	rotationInOffHand = deg2rad(-100)

func onPlayerDamaged():
	if !GameData.player.shieldOnDamageUsedForTurn && randi() % int(chanceToBlockOutOf + 1) == 1:
		GameData.player.damageable = false
		GameData.player.shieldOnDamageUsedForTurn = true