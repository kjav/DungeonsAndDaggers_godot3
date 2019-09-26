class FireSpell extends "SpellBase.gd":
	const missile = preload("res://Projectiles/Missile.tscn")
	const missile_texture = preload("res://assets/fireball.png")

	func _init():
		iconFilePath = "res://assets/red_spell2.png"
		item_name = "Fire Spell"
		texture = preload("res://assets/red_spell2.png")

	func onUse():
		var closest_enemy = GameData.closestEnemy()
		
		if closest_enemy and GameData.player.consume_stat("mana", 1):
				.onUse()
				launchFireball(closest_enemy)

	func launchFireball(closest_enemy):
		var new_missile = missile.instance()
		#Audio.playSoundEffect("Fireball_Flying")
		GameData.player.get_parent().add_child(new_missile)
		
		new_missile.init(
			closest_enemy.get_path(),
			missile_texture,
			GameData.player.get_position(),
			25,
			10,
			"Fireball_Hit",
			Vector2(4, 4)
		)

class PushSpell extends "SpellBase.gd":
	func _init():
		iconFilePath = "res://assets/swirl_spell.png"
		item_name = "Push Spell"
		texture = preload("res://assets/swirl_spell.png")

	func onUse():
		var enemiesToPush = GameData.getEnemiesWithinAreaAroundPlayer(3)
		#this probably needs to be in distance order
		
		if enemiesToPush.size() > 0:# and GameData.player.consume_stat("mana", 1):
				#.onUse()
				
				for enemy in enemiesToPush:
					pushEnemy(enemy, 3)
					# animate wind
	
	func pushEnemy(enemy, pushDistance):
		var distance = enemy.position - GameData.player.position
		
		var tileMovementDirection
		var pushesBlocked = 0
		var enemyNewPosition = enemy.position
		
		if abs(distance.x) > abs(distance.y):
			if distance.x > 0:
				tileMovementDirection = Enums.DIRECTION.RIGHT
			else:
				tileMovementDirection = Enums.DIRECTION.LEFT
		else:
			if distance.y > 0:
				tileMovementDirection = Enums.DIRECTION.DOWN
			else:
				tileMovementDirection = Enums.DIRECTION.UP
		
		for i in range(pushDistance):
			if !enemy.handleForcedMove(tileMovementDirection):
				if i != 0: 
					pushesBlocked = (pushDistance - i)
				
				break
		
		if pushesBlocked > 0:
			enemy.takeDamage(float(pushesBlocked) / 2)
		
		if damageToTake > 0:
			enemy.takeDamage(damageToTake)
