class FireSpell extends "SpellBase.gd":
	const missile = preload("res://Projectiles/Missile.tscn")
	const missile_texture = preload("res://assets/fireball.png")

	func _init():
		iconFilePath = "res://assets/red_spell2.png"
		item_name = "Fire"
		texture = preload("res://assets/red_spell2.png")
		rarity = Enums.WEAPONRARITY.RARE

	func onUse():
		if not .allowedToUse():
			.tryAgainOnTurnEnd()
			return
		
		var closest_enemy = GameData.closestEnemy()
		
		if closest_enemy and GameData.player.consume_stat("mana", 1):
				.onUse()
				launchFireball(closest_enemy)
		else:
			GameData.hud.addEventMessage("No target in range")

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

class RepelSpell extends "SpellBase.gd":
	const Blast = preload("res://Effects/Blast.tscn")
	
	func _init():
		iconFilePath = "res://assets/swirl_spell.png"
		item_name = "Repel"
		texture = preload("res://assets/swirl_spell.png")
		rarity = Enums.WEAPONRARITY.UNCOMMON

	func onUse():
		if not .allowedToUse():
			.tryAgainOnTurnEnd()
			return;

		var enemiesToPush = GameData.getEnemiesWithinAreaAroundPlayer(3)
		
		if enemiesToPush.size() > 0 and GameData.player.consume_stat("mana", 1):
				.onUse()
				
				for enemy in enemiesToPush:
					pushEnemy(enemy, 3)
					
				var blastInstance = Blast.instance()
				blastInstance.position = GameData.player.position + Vector2(GameData.TileSize / 2, GameData.TileSize / 2)
				GameData.effectsNode.add_child(blastInstance)
				blastInstance.play()
		else:
			GameData.hud.addEventMessage("No targets in range")
	
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
				pushesBlocked = (pushDistance - i)
				
				break
		
		if pushesBlocked > 0:
			enemy.takeDamage(float(pushesBlocked) / 2)

class EarthquakeSpell extends "SpellBase.gd":
	const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")
	
	func _init():
		iconFilePath = "res://assets/brown_spell.png"
		item_name = "Earthquake"
		texture = preload("res://assets/brown_spell.png")
		rarity = Enums.WEAPONRARITY.UNCOMMON
	
	func onUse():
		if not .allowedToUse():
			.tryAgainOnTurnEnd()
			return
		
		var enemiesInArea = GameData.getEnemiesWithinAreaAroundPlayer(2)
		
		if enemiesInArea.size() > 0 and GameData.player.consume_stat("mana", 1):
			.onUse()
			addHeavyImpacts()
			GameData.player.get_node("Camera2D").shake(0.2, 50, 50)
			damageEnemies(enemiesInArea)
			pass
		else:
			GameData.hud.addEventMessage("No targets in range")
	
	func damageEnemies(enemiesInArea):
		for enemy in enemiesInArea:
			enemy.takeDamage(3)
	
	func addHeavyImpacts():
		var attackPositions = PositionHelper.getRelativeCoordinatesAroundPoint(1)
		var attackPositions2 = PositionHelper.getRelativeCoordinatesAroundPoint(2)
		
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

class TeleportSpell extends "SpellBase.gd":
	func _init():
		iconFilePath = "res://assets/gem_spell.png"
		item_name = "Teleport"
		texture = preload("res://assets/gem_spell.png")

	func onUse():		
		.onUse()
		GameData.player.get_node("LightBlip").play("preparing")
		GameData.player.get_node("LightBlip").show()
		GameData.player.readyToTeleportOnTileSelect = true
		GameData.hud.SetVisibilityOfTeleportWarning(true)

class MissileSpell extends "SpellBase.gd":
	const missile = preload("res://Projectiles/Missile.tscn")
	const missile_texture = preload("res://assets/pellet.png")
	
	func _init():
		iconFilePath = "res://assets/triangle_spell.png"
		item_name = "Missile"
		texture = preload("res://assets/triangle_spell.png")
	
	func onUse():
		if not .allowedToUse():
			.tryAgainOnTurnEnd()
			return

		var closest_enemy = GameData.closestEnemy()
		
		if closest_enemy and GameData.player.consume_stat("mana", 0.5):
			.onUse()
			launchPellet(closest_enemy)
		else:
			GameData.hud.addEventMessage("No target in range")

	func launchPellet(closest_enemy):
		var new_missile = missile.instance()
		#Audio.playSoundEffect("Missile_Flying")
		GameData.player.get_parent().add_child(new_missile)
		
		new_missile.init(
			closest_enemy.get_path(),
			missile_texture,
			GameData.player.get_position(),
			25,
			2,
			"Missile_Hit",
			Vector2(0.2, 0.2)
		)

class StunSpell extends "SpellBase.gd":
	func _init():
		iconFilePath = "res://assets/rune_spell.png"
		item_name = "Stun"
		texture = preload("res://assets/rune_spell.png")
	
	func onUse():
		if not .allowedToUse():
			.tryAgainOnTurnEnd()
			return

		var closest_enemy = GameData.closestEnemy()
		
		if closest_enemy and GameData.player.consume_stat("mana", 0.5):
			.onUse()
			closest_enemy.addStun(randi()%2+2)
		else:
			GameData.hud.addEventMessage("No target in range")