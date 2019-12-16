extends "SpellBase.gd"

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
