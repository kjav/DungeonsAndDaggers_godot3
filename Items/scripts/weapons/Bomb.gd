extends "WeaponBase.gd"

const missile = preload("res://Projectiles/Missile.tscn")

func _init():
	._init()
	textureFilePath = "res://assets/bomb.png"
	texture = preload("res://assets/bomb.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/bomb.png"
	iconTexture = preload("res://assets/bomb.png")
	item_name = "Bomb"
	item_description = "Bombs are single use and hit the first enemy in a straight line. It deals 6 damage and 3 to anything within a tile."
	rarity = Enums.WEAPONRARITY.UNCOMMON
	ammo = 1
	relativeAttackPositions = [Vector2(0, -1), Vector2(0, -2), Vector2(0, -3), Vector2(0, -4), Vector2(0, -5)]
	damage = 0
	offset = Vector2(-10, -10)
	rotationInHand = deg2rad(45)
	doesDamage = false

func onAttack(target, attackDirection, isFirstCollision):
	if target:
		var new_missile = missile.instance()
		GameData.player.get_parent().add_child(new_missile)
		
		new_missile.init(
			GameData.player,
			target,
			texture,
			GameData.player.getPrimaryHandPosition(),
			25,
			6,
			"Arrow_Hit",
			Vector2(0.5, 0.5),
			true,
			true
		)
		
		.onAttack(target, attackDirection, isFirstCollision)
