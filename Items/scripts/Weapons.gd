class BasicSword extends "Weapon.gd":
	func _init():
		iconFilePath = "res://assets/basic_sword.png"
		texture = preload("res://assets/basic_sword.png")
		item_name = "Basic Sword"
		damage = 3
		holdOffset = [Vector2(8.6666, 14), Vector2(24.3333, 12), Vector2(12, 14), Vector2(18.3333, 14)]

class BasicShield extends "Weapon.gd":
	func _init():
		iconFilePath = "res://assets/basic_shield.png"
		texture = preload("res://assets/basic_shield.png")
		item_name = "Basic Shield"
		damage = 1
		holdOffset = [Vector2(21.3333, 18), Vector2(10.6666, 15), Vector2(16, 16), Vector2(16, 14)]

class BasicSpear extends "Weapon.gd":
	func _init():
		iconFilePath = "res://assets/basic_spear.png"
		texture = preload("res://assets/basic_spear.png")
		item_name = "Basic Spear"
		relativeAttackPositions = [Vector2(0, -1)]
		damage = 1
		holdOffset = [Vector2(9, 12), Vector2(23, 12), Vector2(12, 12), Vector2(18, 12)]
		onlyAttacksFirstEnemy = false
