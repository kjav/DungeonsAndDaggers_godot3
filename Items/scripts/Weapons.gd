class Unarmed extends "Weapon.gd":
	func _init():
		iconFilePath = "res://assets/transparent_pixel.png"
		texture = preload("res://assets/transparent_pixel.png")
		item_name = "Your Fist"
		equiptable = false
		damage = 0.5

class BasicSword extends "Weapon.gd":
	func _init():
		iconFilePath = "res://assets/basic_sword.png"
		texture = preload("res://assets/basic_sword.png")
		item_name = "Basic Sword"
		damage = 3
		showBehindHand = true
		offset = Vector2(-30, -30)
		rotationInHand = deg2rad(120)
		rotationInOffHand = deg2rad(55)

class BasicShield extends "Weapon.gd":
	var chanceToBlockOutOf = 10
	
	func _init():
		iconFilePath = "res://assets/basic_shield.png"
		texture = preload("res://assets/basic_shield.png")
		item_name = "Basic Shield"
		damage = 1
	
	func onPlayerDamaged():
		if randi()%chanceToBlockOutOf+1 == 1:
			GameData.player.damageable = false

class BasicSpear extends "Weapon.gd":
	func _init():
		iconFilePath = "res://assets/basic_spear.png"
		texture = preload("res://assets/basic_spear.png")
		item_name = "Basic Spear"
		relativeAttackPositions = [Vector2(0, -1)]
		damage = 1
		onlyAttacksFirstEnemy = false
		showBehindHand = true
		offset = Vector2(-30, -30)
		rotationInHand = deg2rad(120)
		rotationInOffHand = deg2rad(55)

class BasicBow extends "Weapon.gd":
	const missile = preload("res://Projectiles/Missile.tscn")
	const missile_texture = preload("res://assets/arrow.png")
	
	func _init():
		iconFilePath = "res://assets/basic_bow.png"
		texture = preload("res://assets/basic_bow.png")
		item_name = "Basic Bow"
		relativeAttackPositions = [Vector2(0, -1), Vector2(0, -2), Vector2(0, -3), Vector2(0, -4), Vector2(0, -5)]
		damage = 0.5
		onlyAttacksFirstEnemy = true
		showBehindHand = true
		offset = Vector2(10, 22)
		rotationInHand = deg2rad(185)
		rotationInOffHand = deg2rad(145)
		ammo = 3
	
	func onAttack(target):
		if target:
			var new_missile = missile.instance()
			#Audio.playSoundEffect("Arrow_Shot")
			GameData.player.get_parent().add_child(new_missile)
			
			new_missile.init(
				target.get_path(),
				missile_texture,
				GameData.player.getPrimaryHandPosition(),
				25,
				0,
				"Arrow_Hit",
				Vector2(0.5, 0.5)
			)
			
			.onAttack(target)