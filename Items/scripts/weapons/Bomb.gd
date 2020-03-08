extends "WeaponBase.gd"

const missile = preload("res://Projectiles/Missile.tscn")

func _init():
	textureFilePath = "res://assets/bomb.png"
	texture = preload("res://assets/bomb.png")
	iconTextureFilePath = "res://assets/bomb.png"
	iconTexture = preload("res://assets/bomb.png")
	item_name = "Bomb"
	rarity = Enums.WEAPONRARITY.UNCOMMON
	ammo = 1
	relativeAttackPositions = [Vector2(0, -1), Vector2(0, -2), Vector2(0, -3), Vector2(0, -4), Vector2(0, -5)]
	damage = 0
	offset = Vector2(-10, -10)
	rotationInHand = deg2rad(120)
	rotationInOffHand = deg2rad(55)
	doesDamage = false

func onAttack(target):
	if target:
		var new_missile = missile.instance()
		GameData.player.get_parent().add_child(new_missile)
		
		new_missile.init(
			target,
			texture,
			GameData.player.getPrimaryHandPosition(),
			25,
			3,
			"Arrow_Hit",
			Vector2(0.5, 0.5),
			true,
			true
		)
		
		.onAttack(target)
