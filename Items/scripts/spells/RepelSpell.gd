extends "SpellBase.gd"

const Blast = preload("res://Effects/Blast.tscn")

func _init():
	textureFilePath = "res://assets/swirl_spell.webp"
	item_name = "Repel"
	item_description = "Pushes all enemies within 4 tiles away from you. Pushing enemies into walls will cause some damage."
	texture = preload("res://assets/swirl_spell.webp")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return;

	var enemiesToPush = GameData.getCharactersWithinAreaAroundCharacter(GameData.player, 4)
	
	if enemiesToPush.size() > 0 and GameData.player.consume_stat("mana", 1):
			for enemy in enemiesToPush:
				pushEnemy(enemy, 4)
				
			var blastInstance = Blast.instance()
			blastInstance.position = GameData.player.position + Vector2(GameData.TileSize / 2, GameData.TileSize / 2)
			GameData.effectsNode.add_child(blastInstance)
			blastInstance.play()
			
			.onUse()
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
