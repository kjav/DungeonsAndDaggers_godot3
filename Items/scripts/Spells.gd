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

class EarthquakeSpell extends "SpellBase.gd":
	const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")
	
	func _init():
		iconFilePath = "res://assets/brown_spell.png"
		item_name = "Earthquake Spell"
		texture = preload("res://assets/brown_spell.png")
	
	func onUse():
		var enemiesInArea = GameData.getEnemiesWithinAreaAroundPlayer(2)
		
		if enemiesInArea.size() > 0 and GameData.player.consume_stat("mana", 1):
			.onUse()
			addHeavyImpacts()
			damageEnemies(enemiesInArea)
			pass
	
	func damageEnemies(enemiesInArea):
		for enemy in enemiesInArea:
			enemy.takeDamage(3)
	
	func addHeavyImpacts():
		var attackPositions = [Vector2(0, 1), Vector2(1, 0), Vector2(1, 1), Vector2(0, -1), Vector2(-1, 0), Vector2(-1, -1), Vector2(-1, 1), Vector2(1, -1)]
		var attackPositions2 = [Vector2(0, 2), Vector2(-1, 2), Vector2(-2, 2), Vector2(-2, 1), Vector2(-2, 0), Vector2(-2, -1), Vector2(-2, -2), Vector2(-1, -2), Vector2(0, -2), Vector2(1, -2), Vector2(2, -2), Vector2(2, -1), Vector2(2, 0), Vector2(2, 1), Vector2(2, 2), Vector2(1, 2)]
		
		attackPositions = convertToAbsolutePosition(attackPositions)
		attackPositions2 = convertToAbsolutePosition(attackPositions2)
		
		displayHeavyImpacts(attackPositions)
		
		var timer = Timer.new()
		timer.set_wait_time(0.2)
		timer.connect("timeout", self, "displayHeavyImpacts", [attackPositions2])
		timer.set_one_shot(true)
		GameData.effectsNode.add_child(timer)
		timer.start()
	
	func convertToAbsolutePosition(attackPositions):
		for i in range(attackPositions.size()):
			attackPositions[i] *= GameData.TileSize
			attackPositions[i] += GameData.player.position
		
		return attackPositions
	
	func displayHeavyImpacts(positions):
		for position in positions:
			var heavyImpactInstance = HeavyImpact.instance()
			
			heavyImpactInstance.position = position
			GameData.effectsNode.add_child(heavyImpactInstance)
			heavyImpactInstance.play()