class BasicSword extends "Weapon.gd":
	const texture = preload("res://assets/basic_sword.png")
	
	func _init():
		iconFilePath = "res://assets/basic_sword.png"
		name = "Basic Sword"
		damage = 3
		holdOffset = [Vector2(10.6666, 16), Vector2(21.3333, 16), Vector2(16, 18), Vector2(16, 18)]

	func onUse():
		pass

class BasicShield extends "Weapon.gd":
	const texture = preload("res://assets/basic_shield.png")
	
	func _init():
		iconFilePath = "res://assets/basic_shield.png"
		name = "Basic Shield"
		damage = 1
		holdOffset = [Vector2(21.3333, 18), Vector2(10.6666, 16), Vector2(16, 16), Vector2(16, 18)]

	#todo, somehow needs to block damage or something
	func onUse():
		pass

class BasicSpear extends "Weapon.gd":
	const texture = preload("res://assets/basic_spear.png")
	
	func _init():
		iconFilePath = "res://assets/basic_spear.png"
		name = "Basic Spear"
		relativeAttackPositions = [Vector2(0, -1)]
		damage = 1
		holdOffset = [Vector2(10.6666, 16), Vector2(21.3333, 16), Vector2(16, 18), Vector2(16, 18)]
		onlyAttacksFirstEnemy = false
	
	func onUse():
		pass
