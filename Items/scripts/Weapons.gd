class BasicSword extends "Weapon.gd":
	func _init():
		iconFilePath = "res://assets/basic_sword.png"
		texture = preload("res://assets/basic_sword.png")
		item_name = "Basic Sword"
		damage = 3
		showBehindHand = true

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
