extends "WeaponBase.gd"

var chanceToBlockOutOf

func _init():
	._init()
	textureFilePath = "res://assets/basic_shield.webp"
	texture = preload("res://assets/basic_shield.webp")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/basic_shield.webp"
	iconTexture = preload("res://assets/basic_shield.webp")
	item_name = "Common Shield"
	item_description = "Shields work in your offhand and may fully block attacks. Common, on average, blocks 1 in 5 attacks."
	chanceToBlockOutOf = 5
	damage = 1
	isMelee = true
	isOffhand = true
	rotationInHand = deg2rad(0)

func onPlayerDamaged():
	if !GameData.player.shieldOnDamageUsedForTurn && randi() % int(chanceToBlockOutOf + 1) == 1:
		GameData.player.damageable = false
		GameData.player.shieldOnDamageUsedForTurn = true
